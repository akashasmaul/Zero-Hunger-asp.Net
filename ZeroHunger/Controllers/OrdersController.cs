using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ZeroHunger.EF;

namespace ZeroHunger.Controllers
{
    public class OrdersController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            var db = new ZeroHungerEntities5();
            var orders = db.Orders.ToList();

            foreach (var order in orders.ToList().Where(order => order.Status != "Pending"))
                orders.Remove(order);

            var sortedOrders = orders.OrderBy(x => x.Request_Id).ToList();

            return View(sortedOrders);
        }



        [HttpGet]
        public ActionResult Order(int id)
        {
            var db = new ZeroHungerEntities5();
            var model = (from request in db.Requests
                         where request.Id == id
                         select request).SingleOrDefault();

            ViewBag.Employees = db.Employees.ToList();

            return View(model);
        }
        [HttpGet]
        public ActionResult SendOrder(int id, int requestId)
        {
            var db = new ZeroHungerEntities5();
            db.Orders.Add(new Order
            {
                Request_Id = requestId,
                Employee_id = id,
                Order_Date = DateTime.Now,
                Status = "Pending"
            });

            var request = db.Requests.SingleOrDefault(e => e.Id == requestId);
            if (request != null)
                request.Status = "Pending";

            db.SaveChanges();

            return RedirectToAction("OrderRequests/" + request.Restaurants_Id, "Restaurants");
        }
        [HttpGet]
        public ActionResult Collect(int id)
        {
            var db = new ZeroHungerEntities5();
            var order = db.Orders.SingleOrDefault(o => o.Id == id);

            if (order == null)
                return RedirectToAction("", "Orders");

            var request = db.Requests.SingleOrDefault(r => r.Id == order.Request_Id);

            if (request == null)
                return RedirectToAction("", "Orders");

            order.Status = request.Status = "Collected";
            db.Histories.Add(new History
            {
                Order_Id = order.Id,
                Employee_Id = order.Employee_id,
                Restaurant_Id = request.Restaurants_Id,
                Collection_Time = DateTime.Now
            });

            db.SaveChanges();

            return RedirectToAction("", "Orders");
        }

        [HttpGet]
        public ActionResult History()
        {
            var db = new ZeroHungerEntities5();
            return View(db.Histories.ToList());
        }


    }


}