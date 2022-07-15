using KB2022.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace KB2022.Controllers
{
    public class CodeDefinition
    {
        public string CodeFile { get; set; }
        public string CodeStyle { get; set; }
        public string Title { get; set; }
    }

    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            var data = new List<CodeDefinition>
            {
                new CodeDefinition
                {
                    CodeFile = "_SQL_01",
                    CodeStyle = "language-sql",
                    Title = "Simple SQL Code example"
                },
                new CodeDefinition
                {
                    CodeFile = "_CS_01",
                    CodeStyle = "language-csharp",
                    Title = "Simple C# Code example"
                },
                new CodeDefinition
                {
                    CodeFile = "_JS_01",
                    CodeStyle = "language-js",
                    Title = "Simple JS Code example"
                }
            };

            return View(data);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}