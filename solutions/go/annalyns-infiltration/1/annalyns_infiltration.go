package annalyn

// CanFastAttack succeeds only when the knight is asleep.
func CanFastAttack(knightIsAwake bool) bool {
	return !knightIsAwake
}

// CanSpy succeeds when at least one character is awake.
func CanSpy(knightIsAwake, archerIsAwake, prisonerIsAwake bool) bool {
	return knightIsAwake || archerIsAwake || prisonerIsAwake
}

// CanSignalPrisoner succeeds when the archer is asleep and prisoner is awake.
func CanSignalPrisoner(archerIsAwake, prisonerIsAwake bool) bool {
	return !archerIsAwake && prisonerIsAwake
}

// CanFreePrisoner succeeds when the guards are asleep and the prisoner is awake,
// or when the dog is present and the archer is asleep.
func CanFreePrisoner(knightIsAwake, archerIsAwake, prisonerIsAwake, petDogIsPresent bool) bool {
	return (!knightIsAwake && !archerIsAwake && prisonerIsAwake) ||
		(petDogIsPresent && !archerIsAwake)
}
