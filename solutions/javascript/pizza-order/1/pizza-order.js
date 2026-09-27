const prices = { Margherita: 7, Caprese: 9, Formaggio: 10 };
const extraPrices = { ExtraSauce: 1, ExtraToppings: 2 };

export function pizzaPrice(pizza, ...extras) {
  return prices[pizza] + extras.reduce((sum, extra) => sum + extraPrices[extra], 0);
}

export function orderPrice(pizzaOrders) {
  let total = 0;
  for (const { pizza, extras } of pizzaOrders) {
    total += pizzaPrice(pizza, ...extras);
  }
  return total;
}
