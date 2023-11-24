package keeper_test

import (
	"testing"

	"github.com/stretchr/testify/require"
	testkeeper "rollkit-ibc/testutil/keeper"
	"rollkit-ibc/x/rollkitibc/types"
)

func TestGetParams(t *testing.T) {
	k, ctx := testkeeper.RollkitibcKeeper(t)
	params := types.DefaultParams()

	k.SetParams(ctx, params)

	require.EqualValues(t, params, k.GetParams(ctx))
}
