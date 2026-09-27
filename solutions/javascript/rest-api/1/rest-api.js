const userBalance = (user) =>
  Object.values(user.owed_by).reduce((sum, amount) => sum + amount, 0) -
  Object.values(user.owes).reduce((sum, amount) => sum + amount, 0);

export class RestAPI {
  constructor(database = { users: [] }) {
    this.database = database;
    this.database.users ??= [];
  }

  get(url) {
    const { searchParams } = new URL(url, 'http://localhost');
    const requested = searchParams.get('users');
    const names = requested === null ? null : requested.split(',').filter(Boolean);
    const users = this.database.users
      .filter((user) => names === null || names.includes(user.name))
      .sort((a, b) => a.name.localeCompare(b.name));
    return { users };
  }

  post(url, payload) {
    if (url === '/add') {
      const user = { name: payload.user, owes: {}, owed_by: {}, balance: 0 };
      this.database.users.push(user);
      return user;
    }

    if (url === '/iou') {
      const lender = this.database.users.find((user) => user.name === payload.lender);
      const borrower = this.database.users.find((user) => user.name === payload.borrower);
      lender.owes ??= {};
      lender.owed_by ??= {};
      borrower.owes ??= {};
      borrower.owed_by ??= {};

      const amountOwedBack = lender.owes[borrower.name] || 0;
      const loan = payload.amount;
      if (amountOwedBack > loan) {
        lender.owes[borrower.name] = amountOwedBack - loan;
        borrower.owed_by[lender.name] = amountOwedBack - loan;
      } else if (amountOwedBack < loan) {
        delete lender.owes[borrower.name];
        delete borrower.owed_by[lender.name];
        lender.owed_by[borrower.name] = (lender.owed_by[borrower.name] || 0) + loan - amountOwedBack;
        borrower.owes[lender.name] = (borrower.owes[lender.name] || 0) + loan - amountOwedBack;
      } else {
        delete lender.owes[borrower.name];
        delete borrower.owed_by[lender.name];
      }

      lender.balance = userBalance(lender);
      borrower.balance = userBalance(borrower);
      return { users: [lender, borrower].sort((a, b) => a.name.localeCompare(b.name)) };
    }

    throw new Error(`Unsupported endpoint: ${url}`);
  }
}
