package splitsecondstopwatch

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
	"time"
)

type SplitSecondStopwatch struct {
	state       string
	currentLap  time.Duration
	total       time.Duration
	previousLap []time.Duration
}

func (sss *SplitSecondStopwatch) Start() error {
	if sss.state == "running" {
		return errors.New("cannot start an already running stopwatch")
	}
	sss.state = "running"
	return nil
}

func (sss *SplitSecondStopwatch) Stop() error {
	if sss.state != "running" {
		return errors.New("cannot stop a stopwatch that is not running")
	}
	sss.state = "stopped"
	return nil
}

func (sss *SplitSecondStopwatch) Reset() error {
	if sss.state != "stopped" {
		return errors.New("cannot reset a stopwatch that is not stopped")
	}
	sss.state = "ready"
	sss.currentLap = 0
	sss.total = 0
	sss.previousLap = nil
	return nil
}

func (sss *SplitSecondStopwatch) Lap() error {
	if sss.state != "running" {
		return errors.New("cannot lap a stopwatch that is not running")
	}
	sss.previousLap = append(sss.previousLap, sss.currentLap)
	sss.currentLap = 0
	return nil
}

func (sss *SplitSecondStopwatch) AdvanceTime(by string) {
	parts := strings.Split(by, ":")
	if len(parts) != 3 {
		return
	}
	hours, err1 := strconv.Atoi(parts[0])
	minutes, err2 := strconv.Atoi(parts[1])
	seconds, err3 := strconv.Atoi(parts[2])
	if err1 != nil || err2 != nil || err3 != nil || sss.state != "running" {
		return
	}
	elapsed := time.Duration(hours)*time.Hour + time.Duration(minutes)*time.Minute + time.Duration(seconds)*time.Second
	sss.currentLap += elapsed
	sss.total += elapsed
}

func (sss *SplitSecondStopwatch) State() string {
	if sss.state == "" {
		return "ready"
	}
	return sss.state
}

func (sss *SplitSecondStopwatch) CurrentLap() string {
	return formatDuration(sss.currentLap)
}

func (sss *SplitSecondStopwatch) Total() string {
	return formatDuration(sss.total)
}

func (sss *SplitSecondStopwatch) PreviousLaps() []string {
	laps := make([]string, len(sss.previousLap))
	for i, lap := range sss.previousLap {
		laps[i] = formatDuration(lap)
	}
	return laps
}

func NewSplitSecondStopwatch() *SplitSecondStopwatch {
	return &SplitSecondStopwatch{state: "ready"}
}

func formatDuration(duration time.Duration) string {
	seconds := int64(duration / time.Second)
	hours := seconds / 3600
	minutes := (seconds % 3600) / 60
	remainingSeconds := seconds % 60
	return fmt.Sprintf("%02d:%02d:%02d", hours, minutes, remainingSeconds)
}
