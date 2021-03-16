using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace permissions_tester.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class HomeController : ControllerBase
	{
		[HttpGet]
		[Authorize]
		public async Task<IActionResult> Get()
		{
			return new OkObjectResult("You have done the thing!");
		}
	}
}
