using System.Collections.Generic;
using System.Threading.Tasks;

namespace permissions_tester.Claims
{
	public interface IPermissionClaimService
	{
		Task<bool> HasClaim(string userId, IEnumerable<string> groups, string claim);
		Task<IEnumerable<string>> GetClaimsAsync(string userId, IEnumerable<string> groups);
	}
}
