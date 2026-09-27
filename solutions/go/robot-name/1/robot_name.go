package robotname

import (
	"crypto/rand"
	"fmt"
	"math/big"
	"sync"
)

const nameSpaceSize = 26 * 26 * 10 * 10 * 10

type Robot struct {
	mu   sync.Mutex
	name string
}

var factory = struct {
	sync.Mutex
	used map[int]struct{}
}{used: make(map[int]struct{}, nameSpaceSize)}

func (r *Robot) Name() (string, error) {
	r.mu.Lock()
	defer r.mu.Unlock()
	if r.name != "" {
		return r.name, nil
	}

	factory.Lock()
	defer factory.Unlock()
	if len(factory.used) == nameSpaceSize {
		return "", fmt.Errorf("robot name space exhausted")
	}
	limit := big.NewInt(nameSpaceSize)
	for {
		n, err := rand.Int(rand.Reader, limit)
		if err != nil {
			return "", fmt.Errorf("generate robot name: %w", err)
		}
		id := int(n.Int64())
		if _, exists := factory.used[id]; exists {
			continue
		}
		factory.used[id] = struct{}{}
		r.name = fmt.Sprintf("%c%c%03d", 'A'+id/26000, 'A'+(id/1000)%26, id%1000)
		return r.name, nil
	}
}

func (r *Robot) Reset() {
	r.mu.Lock()
	r.name = ""
	r.mu.Unlock()
}
