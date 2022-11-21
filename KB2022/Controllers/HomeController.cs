using KB2022.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace KB2022.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly string _codefilesFolder = "CODE_FILES";
        private readonly string _codefilesPath;
        private readonly string _wwwrootDir;

        public HomeController(ILogger<HomeController> logger, IWebHostEnvironment webHostEnvironment)
        {
            _logger = logger;
            _webHostEnvironment = webHostEnvironment;
            _wwwrootDir = _webHostEnvironment.ContentRootPath;
            _codefilesPath = Path.Combine(_wwwrootDir, _codefilesFolder);
        }

        public IActionResult Index()
        {
            var data = new List<CodeDefinition>();

            foreach (var filePath in Directory.GetFiles(_codefilesPath))
            {
                var fileExten = Path.GetExtension(filePath);
                var fileTitle = System.IO.File.ReadLines(filePath).First().Replace("//", "").Trim();

                data.Add(new CodeDefinition
                {
                    CodeFile = filePath,
                    CodeStyle = "language-" + fileExten,
                    Title = fileTitle
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