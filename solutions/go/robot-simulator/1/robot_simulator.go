package robot

// See defs.go for other definitions

// Step 1
// Define N, E, S, W here.

import "fmt"

const (
	N Dir = iota
	E
	S
	W
)

func Right() {
	Step1Robot.Dir = (Step1Robot.Dir + 1) % 4
}

func Left() {
	Step1Robot.Dir = (Step1Robot.Dir + 3) % 4
}

func Advance() {
	switch Step1Robot.Dir {
	case N:
		Step1Robot.Y++
	case E:
		Step1Robot.X++
	case S:
		Step1Robot.Y--
	case W:
		Step1Robot.X--
	}
}

func (d Dir) String() string {
	if int(d) >= 0 && int(d) < 4 {
		return [...]string{"North", "East", "South", "West"}[d]
	}
	return fmt.Sprintf("Dir(%d)", d)
}

// Step 2
// Define Action type here.

type Action struct {
	Command Command
	Done    bool
}

func StartRobot(command chan Command, action chan Action) {
	for next := range command {
		action <- Action{Command: next}
	}
	action <- Action{Done: true}
}

func Room(extent Rect, robot Step2Robot, action chan Action, report chan Step2Robot) {
	for {
		next := <-action
		if next.Done {
			report <- robot
			return
		}
		if next.Command == 'A' {
			advanceWithin(&robot, extent)
		} else {
			applyCommand(&robot, next.Command)
		}
	}
}

// Step 3
// Define Action3 type here.

type Action3 struct {
	Name    string
	Command Command
	Done    bool
}

func StartRobot3(name, script string, action chan Action3, log chan string) {
	for _, command := range []byte(script) {
		action <- Action3{Name: name, Command: Command(command)}
	}
	action <- Action3{Name: name, Done: true}
}

func Room3(extent Rect, robots []Step3Robot, action chan Action3, rep chan []Step3Robot, log chan string) {
	indices := make(map[string]int)
	duplicates := make(map[string]bool)
	invalid := make(map[string]bool)
	unknownLogged := make(map[string]bool)
	positions := make(map[Pos]string)

	for i := range robots {
		name := robots[i].Name
		if name == "" {
			log <- "Robot has no name"
			invalid[name] = true
		}
		if _, exists := indices[name]; exists {
			log <- "Duplicate robot name: " + name
			duplicates[name] = true
			invalid[name] = true
		} else {
			indices[name] = i
		}
		pos := robots[i].Pos
		if pos.Easting < extent.Min.Easting || pos.Easting > extent.Max.Easting ||
			pos.Northing < extent.Min.Northing || pos.Northing > extent.Max.Northing {
			log <- "Robot is outside the room: " + name
			invalid[name] = true
		}
		if other, exists := positions[pos]; exists {
			log <- "Robots occupy the same position: " + other + ", " + name
		} else {
			positions[pos] = name
		}
	}

	done := 0
	for done < len(robots) {
		next := <-action
		if next.Done {
			done++
			continue
		}
		index, exists := indices[next.Name]
		if !exists {
			if !unknownLogged[next.Name] {
				log <- "Action from unknown robot: " + next.Name
				unknownLogged[next.Name] = true
			}
			continue
		}
		if duplicates[next.Name] || invalid[next.Name] {
			continue
		}
		robot := &robots[index].Step2Robot
		switch next.Command {
		case 'L', 'R':
			applyCommand(robot, next.Command)
		case 'A':
			to := destination(robot.Step2Robot)
			if to.Easting < extent.Min.Easting || to.Easting > extent.Max.Easting ||
				to.Northing < extent.Min.Northing || to.Northing > extent.Max.Northing {
				log <- "Robot attempted to advance into a wall: " + next.Name
				continue
			}
			occupied := false
			for otherIndex := range robots {
				if otherIndex != index && robots[otherIndex].Pos == to {
					occupied = true
					break
				}
			}
			if occupied {
				log <- "Robot attempted to advance into another robot: " + next.Name
				continue
			}
			robot.Pos = to
		default:
			log <- "Undefined command: " + string(next.Command)
		}
	}
	rep <- robots
}

func applyCommand(robot *Step2Robot, command Command) {
	switch command {
	case 'L':
		robot.Dir = (robot.Dir + 3) % 4
	case 'R':
		robot.Dir = (robot.Dir + 1) % 4
	}
}

func destination(robot Step2Robot) Pos {
	pos := robot.Pos
	switch robot.Dir {
	case N:
		pos.Northing++
	case E:
		pos.Easting++
	case S:
		pos.Northing--
	case W:
		pos.Easting--
	}
	return pos
}

func advanceWithin(robot *Step2Robot, extent Rect) {
	to := destination(*robot)
	if to.Easting >= extent.Min.Easting && to.Easting <= extent.Max.Easting &&
		to.Northing >= extent.Min.Northing && to.Northing <= extent.Max.Northing {
		robot.Pos = to
	}
}
