package types

const (
	// ModuleName defines the module name
	ModuleName = "rollkitibc"

	// StoreKey defines the primary module store key
	StoreKey = ModuleName

	// MemStoreKey defines the in-memory store key
	MemStoreKey = "mem_rollkitibc"
)

var (
	ParamsKey = []byte("p_rollkitibc")
)

func KeyPrefix(p string) []byte {
	return []byte(p)
}
