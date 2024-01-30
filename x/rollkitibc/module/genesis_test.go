package rollkitibc_test

import (
	"testing"

	"github.com/stretchr/testify/require"
	keepertest "rollkit-ibc/testutil/keeper"
	"rollkit-ibc/testutil/nullify"
	"rollkit-ibc/x/rollkitibc/module"
	"rollkit-ibc/x/rollkitibc/types"
)

func TestGenesis(t *testing.T) {
	genesisState := types.GenesisState{
		Params: types.DefaultParams(),

		// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.RollkitibcKeeper(t)
	rollkitibc.InitGenesis(ctx, k, genesisState)
	got := rollkitibc.ExportGenesis(ctx, k)
	require.NotNil(t, got)

	nullify.Fill(&genesisState)
	nullify.Fill(got)

	// this line is used by starport scaffolding # genesis/test/assert
}
