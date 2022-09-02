﻿using AuthenticationAAD.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace AuthenticationAAD.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IConfiguration _configuration;

        public HomeController(ILogger<HomeController> logger, IConfiguration Configuration)
        {
            _logger = logger;
            _configuration = Configuration;
        }

        public IActionResult Index()
        {
            // Save Azure Maps Client Id from Configuration Settings
            ViewData["ClientId"] = _configuration.GetSection("AzureMaps").GetValue<string>("ClientId");

            return View();
        }

        public IActionResult Creator()
        {
            // Save Azure Maps Client Id from Configuration Settings
            ViewData["ClientId"] = _configuration.GetSection("AzureMaps").GetValue<string>("ClientId");

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [AllowAnonymous]
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}