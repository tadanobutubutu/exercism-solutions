package restapi

import "sort"

// Define the Rest API interface. You should not modify the code in this block.

type User struct {
	Name    string
	Owes    map[string]float64
	OwedBy  map[string]float64
	Balance float64
}

type GetUsersRequest struct {
	Users []string
}

type GetUsersResponse struct {
	Users []User
}

type AddUserRequest struct {
	User string
}

type AddUserResponse struct {
	User User
}

type AddIouRequest struct {
	Lender   string
	Borrower string
	Amount   float64
}

type AddIouResponse struct {
	Users []User
}

type RestApi interface {
	GetUsers(GetUsersRequest) GetUsersResponse
	AddUser(AddUserRequest) AddUserResponse
	AddIou(AddIouRequest) AddIouResponse
}

// Your code goes below here. Implement the RestApi interface.

type Api struct {
	users map[string]User
}

func NewApi(database []User) RestApi {
	api := &Api{users: make(map[string]User, len(database))}
	for _, user := range database {
		api.users[user.Name] = cloneUser(user)
	}
	return api
}

func (a *Api) GetUsers(req GetUsersRequest) GetUsersResponse {
	users := make([]User, 0, len(a.users))
	if len(req.Users) == 0 {
		for _, user := range a.users {
			users = append(users, cloneUser(user))
		}
	} else {
		seen := make(map[string]bool, len(req.Users))
		for _, name := range req.Users {
			if user, ok := a.users[name]; ok && !seen[name] {
				users = append(users, cloneUser(user))
				seen[name] = true
			}
		}
	}
	sort.Slice(users, func(i, j int) bool { return users[i].Name < users[j].Name })
	return GetUsersResponse{Users: users}
}

func (a *Api) AddUser(req AddUserRequest) AddUserResponse {
	user := User{
		Name:   req.User,
		Owes:   make(map[string]float64),
		OwedBy: make(map[string]float64),
	}
	a.users[user.Name] = user
	return AddUserResponse{User: cloneUser(user)}
}

func (a *Api) AddIou(req AddIouRequest) AddIouResponse {
	lender := a.users[req.Lender]
	borrower := a.users[req.Borrower]

	netOwed := lender.OwedBy[borrower.Name] - lender.Owes[borrower.Name] + req.Amount
	delete(lender.OwedBy, borrower.Name)
	delete(lender.Owes, borrower.Name)
	delete(borrower.Owes, lender.Name)
	delete(borrower.OwedBy, lender.Name)
	if netOwed > 0 {
		lender.OwedBy[borrower.Name] = netOwed
		borrower.Owes[lender.Name] = netOwed
	} else if netOwed < 0 {
		lender.Owes[borrower.Name] = -netOwed
		borrower.OwedBy[lender.Name] = -netOwed
	}

	lender.Balance += req.Amount
	borrower.Balance -= req.Amount
	a.users[lender.Name] = lender
	a.users[borrower.Name] = borrower

	users := []User{cloneUser(lender), cloneUser(borrower)}
	sort.Slice(users, func(i, j int) bool { return users[i].Name < users[j].Name })
	return AddIouResponse{Users: users}
}

func cloneUser(user User) User {
	user.Owes = cloneMap(user.Owes)
	user.OwedBy = cloneMap(user.OwedBy)
	return user
}

func cloneMap(source map[string]float64) map[string]float64 {
	copy := make(map[string]float64, len(source))
	for name, amount := range source {
		copy[name] = amount
	}
	return copy
}
