let hasFlower = (garden, row, column, rows, columns) =>
  row >= 0 && row < rows && column >= 0 && column < columns
  && String.get(Array.get(garden, row), column) == '*';

let rec countColumns =
    (garden, row, column, rows, columns, rowOffset, columnOffset, total) =>
  if (columnOffset > 1) {
    total;
  } else {
    let neighborRow = row + rowOffset;
    let neighborColumn = column + columnOffset;
    let nextTotal =
      if ((rowOffset != 0 || columnOffset != 0)
          && hasFlower(garden, neighborRow, neighborColumn, rows, columns)) {
        total + 1;
      } else {
        total;
      };
    countColumns(
      garden,
      row,
      column,
      rows,
      columns,
      rowOffset,
      columnOffset + 1,
      nextTotal,
    );
  };

let rec countRowsAround = (garden, row, column, rows, columns, rowOffset, total) =>
  if (rowOffset > 1) {
    total;
  } else {
    let nextTotal =
      countColumns(
        garden,
        row,
        column,
        rows,
        columns,
        rowOffset,
        -1,
        total,
      );
    countRowsAround(
      garden,
      row,
      column,
      rows,
      columns,
      rowOffset + 1,
      nextTotal,
    );
  };

let rec renderRow = (garden, row, rows, columns, column, output) =>
  if (column >= columns) {
    output;
  } else {
    let character = String.get(Array.get(garden, row), column);
    let cell =
      if (character == '*') {
        "*";
      } else {
        let flowers = countRowsAround(garden, row, column, rows, columns, -1, 0);
        if (flowers == 0) {" "} else {string_of_int(flowers)};
      };
    renderRow(garden, row, rows, columns, column + 1, output ++ cell);
  };

let rec renderRows = (garden, rows, columns, row, output) =>
  if (row >= rows) {
    output;
  } else {
    Array.set(output, row, renderRow(garden, row, rows, columns, 0, ""));
    renderRows(garden, rows, columns, row + 1, output);
  };

let annotate = (garden) => {
  let rows = Array.length(garden);
  if (rows == 0) {
    [||];
  } else {
    let columns = String.length(Array.get(garden, 0));
    let annotated = Array.make(rows, "");
    renderRows(garden, rows, columns, 0, annotated);
    annotated;
  };
};
