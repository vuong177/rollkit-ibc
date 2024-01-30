package keeper_test

import (
	"testing"

	"github.com/stretchr/testify/require"

	keepertest "rollkit-ibc/testutil/keeper"
	"rollkit-ibc/x/rollkitibc/types"
)

func TestGetParams(t *testing.T) {
	k, ctx := keepertest.RollkitibcKeeper(t)
	params := types.DefaultParams()

	require.NoError(t, k.SetParams(ctx, params))
	require.EqualValues(t, params, k.GetParams(ctx))
}
