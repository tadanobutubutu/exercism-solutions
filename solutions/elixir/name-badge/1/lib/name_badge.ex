defmodule NameBadge do
  def print(id, name, department) do
    department = department || "OWNER"
    badge = "#{name} - #{String.upcase(department)}"

    if id do
      "[#{id}] - #{badge}"
    else
      badge
    end
  end
end
