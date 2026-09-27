package airportrobot

// Greeter describes a language-specific greeting implementation.
type Greeter interface {
	LanguageName() string
	Greet(name string) string
}

// SayHello includes the language the robot can speak with its greeting.
func SayHello(name string, greeter Greeter) string {
	return "I can speak " + greeter.LanguageName() + ": " + greeter.Greet(name)
}

type Italian struct{}

func (Italian) LanguageName() string     { return "Italian" }
func (Italian) Greet(name string) string { return "Ciao " + name + "!" }

type Portuguese struct{}

func (Portuguese) LanguageName() string     { return "Portuguese" }
func (Portuguese) Greet(name string) string { return "Olá " + name + "!" }

// Try to solve all the tasks first before running the tests.
