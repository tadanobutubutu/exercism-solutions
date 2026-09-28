module linked_list
  implicit none

  type :: node_t
    integer :: value = 0
    type(node_t), pointer :: previous => null()
    type(node_t), pointer :: next => null()
  end type node_t

  type :: list_t
    type(node_t), pointer :: head => null()
    type(node_t), pointer :: tail => null()
    integer :: count = 0
  end type list_t

contains

  function new() result(list)
    type(list_t) :: list
  end function new

  subroutine push(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val
    type(node_t), pointer :: node

    allocate(node)
    node%value = val
    node%previous => list%tail
    nullify(node%next)
    if (associated(list%tail)) then
      list%tail%next => node
    else
      list%head => node
    end if
    list%tail => node
    list%count = list%count + 1
  end subroutine push

  function pop(list) result(val)
    type(list_t), intent(inout) :: list
    integer :: val
    type(node_t), pointer :: node

    val = 0
    if (.not. associated(list%tail)) return
    node => list%tail
    val = node%value
    if (associated(node%previous)) then
      list%tail => node%previous
      nullify(list%tail%next)
    else
      nullify(list%head)
      nullify(list%tail)
    end if
    deallocate(node)
    list%count = list%count - 1
  end function pop

  subroutine unshift(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val
    type(node_t), pointer :: node

    allocate(node)
    node%value = val
    node%next => list%head
    nullify(node%previous)
    if (associated(list%head)) then
      list%head%previous => node
    else
      list%tail => node
    end if
    list%head => node
    list%count = list%count + 1
  end subroutine unshift

  function shift(list) result(val)
    type(list_t), intent(inout) :: list
    integer :: val
    type(node_t), pointer :: node

    val = 0
    if (.not. associated(list%head)) return
    node => list%head
    val = node%value
    if (associated(node%next)) then
      list%head => node%next
      nullify(list%head%previous)
    else
      nullify(list%head)
      nullify(list%tail)
    end if
    deallocate(node)
    list%count = list%count - 1
  end function shift

  function length(list) result(n)
    type(list_t), intent(in) :: list
    integer :: n
    n = list%count
  end function length

  subroutine delete(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val
    type(node_t), pointer :: node

    node => list%head
    do while (associated(node))
      if (node%value == val) then
        if (associated(node%previous)) then
          node%previous%next => node%next
        else
          list%head => node%next
        end if
        if (associated(node%next)) then
          node%next%previous => node%previous
        else
          list%tail => node%previous
        end if
        deallocate(node)
        list%count = list%count - 1
        return
      end if
      node => node%next
    end do
  end subroutine delete

  subroutine destroy(list)
    type(list_t), intent(inout) :: list
    type(node_t), pointer :: node, next_node

    node => list%head
    do while (associated(node))
      next_node => node%next
      deallocate(node)
      node => next_node
    end do
    nullify(list%head)
    nullify(list%tail)
    list%count = 0
  end subroutine destroy

end module linked_list
