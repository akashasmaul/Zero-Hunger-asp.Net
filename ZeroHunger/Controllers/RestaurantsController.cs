using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ZeroHunger.EF;

namespace ZeroHunger.Controllers
{
    public class RestaurantsController : Controller
    {
        // GET: Restaurants
        public ActionResult Index()
        {
            var db = new ZeroHungerEntities5();
            return View(db.Restaurants.ToList());
        }
        [HttpPost]
        public ActionResult MakeRequest(Request model)
        {
            var db = new ZeroHungerEntities5();
            db.Requests.Add(new Request
            {
                Restaurants_Id = model.Id,
                Description = model.Description,
                Expiry_Date = model.Expiry_Date,
                Status = "Waiting"
            });
            db.SaveChanges();

            return RedirectToAction("Index", "Restaurants");
        }

        [HttpGet]
        public ActionResult ViewRequests(int id)
        {
            var db = new ZeroHungerEntities5();
            var model = (from restaurant in db.Restaurants
                         where restaurant.Id == id
                         select restaurant).SingleOrDefault();

            ViewBag.Restaurants = db.Restaurants.ToList();
            ViewBag.Requests = (from request in db.Requests
                                where request.Restaurants_Id == id
                                select request).ToList();

            return View(model);
        }
        [HttpGet]
        public ActionResult OrderRequests(int id)
        {
            var db = new ZeroHungerEntities5();
            var model = (from restaurant in db.Restaurants
                         where restaurant.Id == id
                         select restaurant).SingleOrDefault();

            ViewBag.Restaurants = db.Restaurants.ToList();
            ViewBag.Requests = (from request in db.Requests
                                where request.Restaurants_Id == id
                                select request).ToList();

            return View(model);
        }

        [HttpGet]
        public ActionResult Requests()
        {
            var db = new ZeroHungerEntities5();
            return View(db.Restaurants.ToList());
        }
    }
}