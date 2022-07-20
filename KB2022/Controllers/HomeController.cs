using KB2022.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace KB2022.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public HomeController(ILogger<HomeController> logger, IWebHostEnvironment webHostEnvironment)
        {
            _logger = logger;
            _webHostEnvironment = webHostEnvironment;
        }

        public IActionResult Index()
        {
            var data = new List<CodeDefinition>();
            var wwwrootDir = _webHostEnvironment.ContentRootPath;
            var path = Path.Combine(wwwrootDir, "CODE_FILES");

            foreach (var filePath in Directory.GetFiles(path))
            {
                var exten = Path.GetExtension(filePath);
                data.Add(new CodeDefinition
                {
                    CodeFile = filePath,
                    CodeStyle = "language-" + exten,
                    Title = "Simple " + exten.ToUpper() + " Code example"
                });
            }

            return View(data);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}