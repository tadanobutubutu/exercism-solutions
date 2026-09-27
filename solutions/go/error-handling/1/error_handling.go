package erratum

import (
	"errors"
	"fmt"
)

func Use(opener ResourceOpener, input string) (result error) {
	var resource Resource
	for {
		opened, err := opener()
		if err != nil {
			var transient TransientError
			var transientPointer *TransientError
			if errors.As(err, &transient) || errors.As(err, &transientPointer) {
				continue
			}
			return err
		}
		resource = opened
		break
	}

	defer func() {
		if err := resource.Close(); result == nil && err != nil {
			result = err
		}
	}()
	defer func() {
		if recovered := recover(); recovered != nil {
			switch value := recovered.(type) {
			case FrobError:
				resource.Defrob(value.defrobTag)
				result = value
			case *FrobError:
				resource.Defrob(value.defrobTag)
				result = value
			case error:
				var frob FrobError
				var frobPointer *FrobError
				if errors.As(value, &frob) {
					resource.Defrob(frob.defrobTag)
					result = value
				} else if errors.As(value, &frobPointer) {
					resource.Defrob(frobPointer.defrobTag)
					result = value
				} else {
					result = value
				}
			default:
				result = fmt.Errorf("%v", recovered)
			}
		}
	}()

	resource.Frob(input)
	return result
}
