#!/usr/bin/env node

// The above line is a shebang. On Unix-like operating systems, or environments,
// this will allow the script to be run by node, and thus turn this JavaScript
// file into an executable. In other words, to execute this file, you may run
// the following from your terminal:
//
// ./grep.js args
//
// If you don't have a Unix-like operating system or environment, for example
// Windows without WSL, you can use the following inside a window terminal,
// such as cmd.exe:
//
// node grep.js args
//
// Read more about shebangs here: https://en.wikipedia.org/wiki/Shebang_(Unix)

const fs = require('fs');
const path = require('path');

/**
 * Reads the given file and returns lines.
 *
 * This function works regardless of POSIX (LF) or windows (CRLF) encoding.
 *
 * @param {string} file path to file
 * @returns {string[]} the lines
 */
function readLines(file) {
  const data = fs.readFileSync(path.resolve(file), { encoding: 'utf-8' });
  return data.split(/\r?\n/);
}

const VALID_OPTIONS = [
  'n', // add line numbers
  'l', // print file names where pattern is found
  'i', // ignore case
  'v', // reverse files results
  'x', // match entire line
];

const ARGS = process.argv;

function main(args) {
  const flags = new Set();
  let index = 2;
  while (index < args.length && args[index].startsWith('-') && args[index] !== '-') {
    for (const option of args[index].slice(1)) {
      if (!VALID_OPTIONS.includes(option)) {
        console.error(`Unknown flag: -${option}`);
        process.exitCode = 1;
        return;
      }
      flags.add(option);
    }
    index += 1;
  }

  const pattern = args[index];
  const files = args.slice(index + 1);
  if (pattern === undefined || files.length === 0) return;

  const output = [];
  for (const file of files) {
    const matchingLines = readLines(file).flatMap((line, lineIndex) => {
      const searchableLine = flags.has('i') ? line.toLowerCase() : line;
      const searchablePattern = flags.has('i') ? pattern.toLowerCase() : pattern;
      let matches = flags.has('x')
        ? searchableLine === searchablePattern
        : searchableLine.includes(searchablePattern);
      if (flags.has('v')) matches = !matches;
      if (!matches) return [];

      const prefix = [];
      if (files.length > 1) prefix.push(file);
      if (flags.has('n')) prefix.push(String(lineIndex + 1));
      return [`${prefix.length > 0 ? `${prefix.join(':')}:` : ''}${line}`];
    });

    if (flags.has('l')) {
      if (matchingLines.length > 0) output.push(file);
    } else {
      output.push(...matchingLines);
    }
  }

  if (output.length > 0) console.log(output.join('\n'));
}

try {
  main(ARGS);
} catch (error) {
  console.error(error.message);
  process.exitCode = 1;
}
