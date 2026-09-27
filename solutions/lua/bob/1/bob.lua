local bob = {}

function bob.hey(say)
  local message = say:match('^%s*(.-)%s*$')
  if message == '' then return 'Fine. Be that way!' end

  local has_letters = message:find('%a') ~= nil
  local yelling = has_letters and message:upper() == message
  local question = message:sub(-1) == '?'
  if yelling and question then return "Calm down, I know what I'm doing!" end
  if yelling then return 'Whoa, chill out!' end
  if question then return 'Sure.' end
  return 'Whatever.'
end

return bob
