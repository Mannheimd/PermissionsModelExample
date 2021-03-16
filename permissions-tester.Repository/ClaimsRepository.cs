using Dapper;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace permissions_tester.Repository
{
	public class ClaimsRepository : IClaimsRepository
	{
		public async Task<IEnumerable<string>> GetClaimsByUserAndGroups(string userId, IEnumerable<string> groups)
		{
			using var connection = new SqlConnection("Server=(localdb)\\projectsv13;Integrated Security=true;Initial Catalog=PermissionsTest;");

			var query = @"SELECT Claims.ClaimName
FROM Claims
INNER JOIN Roles ON Roles.AllowsClaim = Claims.Id
WHERE Roles.RoleName IN
(
	SELECT Roles.RoleName
	FROM Roles
	INNER JOIN UserRoleAssignments ON UserRoleAssignments.RoleName = Roles.RoleName
	WHERE UserRoleAssignments.UserADId = @UserId
	UNION
	SELECT Roles.RoleName
	FROM Roles
	INNER JOIN Groups ON Groups.RoleName = Roles.RoleName
	WHERE Groups.GroupId IN @GroupIds
)";

			var parameters = new { UserId = userId, GroupIds = groups };

			return await connection.QueryAsync<string>(query, parameters);
		}
	}
}
