package keeper

import (
	"rollkit-ibc/x/rollkitibc/types"
)

var _ types.QueryServer = Keeper{}
