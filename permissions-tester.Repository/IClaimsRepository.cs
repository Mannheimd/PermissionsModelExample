using System.Collections.Generic;
using System.Threading.Tasks;

namespace permissions_tester.Repository
{
	public interface IClaimsRepository
	{
		Task<IEnumerable<string>> GetClaimsByUserAndGroups(string userId, IEnumerable<string> groups);
	}
}