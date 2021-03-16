using permissions_tester.Repository;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace permissions_tester.Claims
{
	public class PermissionClaimService : IPermissionClaimService
	{
		private readonly IClaimsRepository _claimsRepository;

		public PermissionClaimService(IClaimsRepository claimsRepository)
		{
			_claimsRepository = claimsRepository;
		}

		public async Task<bool> HasClaim(string userId, IEnumerable<string> groups, string claim)
		{
			var claims = await GetClaimsAsync(userId, groups);

			return claims.Contains(claim);
		}

		public async Task<IEnumerable<string>> GetClaimsAsync(string userId, IEnumerable<string> groups)
		{
			return await _claimsRepository.GetClaimsByUserAndGroups(userId, groups);
		}
	}
}
