package react

type reactor struct {
	cells []*cell
}

type cell struct {
	reactor       *reactor
	value         int
	input         bool
	dependencies  []Cell
	lastInputs    []int
	compute1      func(int) int
	compute2      func(int, int) int
	callbacks     map[uint64]func(int)
	callbackOrder []uint64
	nextCallback  uint64
}

type canceler struct {
	cell *cell
	id   uint64
}

func (c *canceler) Cancel() {
	if c == nil || c.cell == nil {
		return
	}
	delete(c.cell.callbacks, c.id)
}

func (c *cell) Value() int {
	return c.value
}

func (c *cell) SetValue(value int) {
	if !c.input || c.value == value {
		return
	}
	c.value = value
	c.reactor.update()
}

func (c *cell) AddCallback(callback func(int)) Canceler {
	c.nextCallback++
	if c.callbacks == nil {
		c.callbacks = make(map[uint64]func(int))
	}
	c.callbacks[c.nextCallback] = callback
	c.callbackOrder = append(c.callbackOrder, c.nextCallback)
	return &canceler{cell: c, id: c.nextCallback}
}

func New() Reactor {
	return &reactor{}
}

func (r *reactor) CreateInput(initial int) InputCell {
	created := &cell{reactor: r, value: initial, input: true}
	r.cells = append(r.cells, created)
	return created
}

func (r *reactor) CreateCompute1(dep Cell, compute func(int) int) ComputeCell {
	created := &cell{
		reactor:      r,
		dependencies: []Cell{dep},
		lastInputs:   []int{dep.Value()},
		compute1:     compute,
		value:        compute(dep.Value()),
	}
	r.cells = append(r.cells, created)
	return created
}

func (r *reactor) CreateCompute2(dep1, dep2 Cell, compute func(int, int) int) ComputeCell {
	first, second := dep1.Value(), dep2.Value()
	created := &cell{
		reactor:      r,
		dependencies: []Cell{dep1, dep2},
		lastInputs:   []int{first, second},
		compute2:     compute,
		value:        compute(first, second),
	}
	r.cells = append(r.cells, created)
	return created
}

func (r *reactor) update() {
	changed := make([]*cell, 0)
	for _, current := range r.cells {
		if current.input || !current.recompute() {
			continue
		}
		changed = append(changed, current)
	}
	for _, current := range changed {
		value := current.value
		for _, id := range current.callbackOrder {
			if callback := current.callbacks[id]; callback != nil {
				callback(value)
			}
		}
	}
}

func (c *cell) recompute() bool {
	inputs := make([]int, len(c.dependencies))
	changed := false
	for i, dependency := range c.dependencies {
		inputs[i] = dependency.Value()
		if inputs[i] != c.lastInputs[i] {
			changed = true
		}
	}
	if !changed {
		return false
	}
	c.lastInputs = inputs
	value := c.value
	if c.compute1 != nil {
		value = c.compute1(inputs[0])
	} else if c.compute2 != nil {
		value = c.compute2(inputs[0], inputs[1])
	}
	if value == c.value {
		return false
	}
	c.value = value
	return true
}
