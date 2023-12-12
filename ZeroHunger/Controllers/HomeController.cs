using AutoMapper;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ZeroHunger.DTO;
using ZeroHunger.EF;

namespace ZeroHunger.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Employees()
        {
            var db = new ZeroHungerEntities5();
            return View(db.Employees.ToList());
        }

        [HttpGet]
        public ActionResult AddEmployees()
        {
            

            return View();
        }
        [HttpPost]
        public ActionResult AddEmployees(EmployeeDTO model)
        {
            try
            {
                var db = new ZeroHungerEntities5();
                model.Sex = "Male";
                db.Employees.Add(Convert(model));
                db.SaveChanges();
               
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                Exception raise = dbEx;
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        string message = string.Format("{0}:{1}",
                            validationErrors.Entry.Entity.ToString(),
                            validationError.ErrorMessage);
                        // raise a new exception nesting
                        // the current instance as InnerException
                        raise = new InvalidOperationException(message, raise);
                    }
                }
                
            }
            return RedirectToAction("Employees", "Home");

        }
        EmployeeDTO Convert(Employee s)
        {
            return new EmployeeDTO()
            {

                Id = s.Id,
                Sex = s.Sex,
                Name = s.Name,
                Email = s.Email,
                Age = s.Age
            };
        }

        Employee Convert(EmployeeDTO s)
        {
            return new Employee()
            {

                Id = s.Id,
                Sex = s.Sex,
                Name = s.Name,
                Email = s.Email,
                Age = s.Age
            };
        }

        [HttpGet]
        public ActionResult DeleteEmployee(int id)
        {
            var employee = new Employee() { Id = id };

            using (var context = new ZeroHungerEntities5())
            {
                context.Employees.Attach(employee);
                context.Employees.Remove(employee);
                context.SaveChanges();
            }

            return RedirectToAction("Employees", "Home");
        }

        [HttpGet]
        public ActionResult UpdateEmployee(int id)
        {
            var db = new ZeroHungerEntities5();
            var model = (from employee in db.Employees
                         where employee.Id == id
                         select employee).SingleOrDefault();

            return View(model);
        }

        [HttpPost]
        public ActionResult UpdateEmployee(Employee model)
        {
            var db = new ZeroHungerEntities5();
            var employee = db.Employees.SingleOrDefault(e => e.Id == model.Id);

            if (employee != null)
            {
                employee.Name = model.Name;
                employee.Email = model.Email;
                employee.Age = model.Age;
                employee.Sex = "Male";
                db.SaveChanges();
            }

            return RedirectToAction("Employees", "Home");
        }
        [HttpGet]
        public ActionResult AddRestaurants()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddRestaurants(Restaurant restaurant)
        {
            var db = new ZeroHungerEntities5();
            db.Restaurants.Add(restaurant);
            db.SaveChanges();
            return RedirectToAction("", "Restaurants");
        }

    }
}