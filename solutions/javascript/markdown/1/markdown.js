function wrap(text, tag) {
  return `<${tag}>${text}</${tag}>`;
}

function parseInline(text) {
  return text
    .replace(/__([^_]+)__/g, '<strong>$1</strong>')
    .replace(/_([^_]+)_/g, '<em>$1</em>');
}

function parseLine(text, list) {
  const headerMatch = text.match(/^(#{1,6})\s(.+)/);
  if (headerMatch) {
    const level = headerMatch[1].length;
    const content = parseInline(headerMatch[2]);
    const html = wrap(content, `h${level}`);
    return list ? `</ul>${html}` : html;
  }

  if (text.startsWith('* ')) {
    const content = parseInline(text.slice(2));
    const html = wrap(content, 'li');
    return list ? html : `<ul>${html}`;
  }

  const content = parseInline(text);
  const html = wrap(content, 'p');
  return list ? `</ul>${html}` : html;
}

export function parse(markdown) {
  const lines = markdown.split('\n');
  let result = '';
  let inList = false;
  for (const line of lines) {
    const parsed = parseLine(line, inList);
    inList = line.startsWith('* ');
    result += parsed;
  }
  if (inList) result += '</ul>';
  return result;
}
