import json


class RestAPI:
    def __init__(self, database=None):
        """Initialize the REST API with a database."""
        self.database = database or {"users": []}
    
    def get(self, url, payload=None):
        """Handle GET requests."""
        if url == "/users":
            return self._get_users(payload)
        else:
            raise ValueError(f"Unknown URL: {url}")
    
    def post(self, url, payload=None):
        """Handle POST requests."""
        if url == "/add":
            return self._add_user(payload)
        elif url == "/iou":
            return self._add_iou(payload)
        else:
            raise ValueError(f"Unknown URL: {url}")
    
    def _get_users(self, payload=None):
        """Get users from the database.
        
        If payload is provided, return only the specified users.
        Otherwise, return all users.
        """
        if payload:
            data = json.loads(payload)
            user_names = data.get("users", [])
            # Filter to requested users and sort by name
            filtered_users = [u for u in self.database["users"] if u["name"] in user_names]
            filtered_users.sort(key=lambda u: u["name"])
            return json.dumps({"users": filtered_users})
        else:
            # Return all users sorted by name
            users = sorted(self.database["users"], key=lambda u: u["name"])
            return json.dumps({"users": users})
    
    def _add_user(self, payload):
        """Add a new user to the database."""
        data = json.loads(payload)
        name = data["user"]
        
        new_user = {
            "name": name,
            "owes": {},
            "owed_by": {},
            "balance": 0.0
        }
        
        self.database["users"].append(new_user)
        return json.dumps(new_user)
    
    def _add_iou(self, payload):
        """Add an IOU between two users.
        
        Debts are net: if A owes B and B lends to A, the debts cancel.
        """
        data = json.loads(payload)
        lender_name = data["lender"]
        borrower_name = data["borrower"]
        amount = data["amount"]
        
        # Find the users
        lender = self._find_user(lender_name)
        borrower = self._find_user(borrower_name)
        
        # The key insight: we need to track the NET debt between two users
        # If A owes B $3 and then B lends A $2, net debt is A owes B $1
        
        # Current state: what does lender owe borrower, and what does borrower owe lender?
        lender_owes_borrower = lender["owes"].get(borrower_name, 0.0)
        borrower_owes_lender = borrower["owes"].get(lender_name, 0.0)
        
        # New transaction: lender gives borrower 'amount', so borrower owes lender 'amount'
        borrower_owes_lender += amount
        
        # Clear both debts to recalculate net
        if borrower_name in lender["owes"]:
            del lender["owes"][borrower_name]
        if borrower_name in lender["owed_by"]:
            del lender["owed_by"][borrower_name]
        
        if lender_name in borrower["owes"]:
            del borrower["owes"][lender_name]
        if lender_name in borrower["owed_by"]:
            del borrower["owed_by"][lender_name]
        
        # Now set the net debt
        if borrower_owes_lender > lender_owes_borrower:
            # Borrower owes lender (after netting)
            net = borrower_owes_lender - lender_owes_borrower
            borrower["owes"][lender_name] = net
            lender["owed_by"][borrower_name] = net
        elif lender_owes_borrower > borrower_owes_lender:
            # Lender owes borrower (after netting)
            net = lender_owes_borrower - borrower_owes_lender
            lender["owes"][borrower_name] = net
            borrower["owed_by"][lender_name] = net
        # else: they cancel out completely, no debt remains
        
        # Recalculate balances
        lender["balance"] = sum(lender["owed_by"].values()) - sum(lender["owes"].values())
        borrower["balance"] = sum(borrower["owed_by"].values()) - sum(borrower["owes"].values())
        
        # Return the updated users sorted by name
        users = sorted([lender, borrower], key=lambda u: u["name"])
        return json.dumps({"users": users})
    
    def _find_user(self, name):
        """Find a user by name."""
        for user in self.database["users"]:
            if user["name"] == name:
                return user
        raise ValueError(f"User not found: {name}")
