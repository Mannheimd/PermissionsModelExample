using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using permissions_tester.Claims;

namespace permissions_tester.Controllers
{
	//[Authorize]
	[Route("api/[controller]")]
	[ApiController]
	public class HomeController : ControllerBase
	{
		private readonly IPermissionClaimService _permissionClaimService;

		public HomeController(IPermissionClaimService permissionClaimService)
		{
			_permissionClaimService = permissionClaimService;
		}

		[HttpGet]
		public async Task<IActionResult> Get()
		{
			var hasClaim = await _permissionClaimService.HasClaim(string.Empty, new List<string> { "Minions" }, "CanEditTheFinances");

			if (!hasClaim)
			{
				return new UnauthorizedResult();
			}

			return new OkObjectResult("You have done the thing!");
		}
	}
}
