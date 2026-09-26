import re


def grep(pattern, flags, files):
    options = set(flags.split())
    ignore_case = "-i" in options
    invert = "-v" in options
    whole_line = "-x" in options
    line_number = "-n" in options
    file_names = "-l" in options
    multiple_files = len(files) > 1
    regex = re.compile(pattern, re.IGNORECASE if ignore_case else 0)
    output = []

    for filename in files:
        with open(filename) as stream:
            matches = []
            for number, line in enumerate(stream, 1):
                text = line.rstrip("\n")
                matched = bool(regex.fullmatch(text) if whole_line else regex.search(text))
                if matched != invert:
                    matches.append((number, line))
            if not matches:
                continue
            if file_names:
                output.append(f"{filename}\n")
                continue
            for number, line in matches:
                prefix = f"{filename}:" if multiple_files else ""
                if line_number:
                    prefix += f"{number}:"
                output.append(prefix + line)

    return "".join(output)
