using ServerSidePaginationUsingSP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;

namespace ServerSidePaginationUsingSP.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public JsonResult GetDetails()
        {
            DBFirstDemoEntities1 _context = new DBFirstDemoEntities1();
            List<GetEmployeeDetails_Result> data = new List<GetEmployeeDetails_Result>();
            var start = (Convert.ToInt32(Request["start"]));
            var Length = (Convert.ToInt32(Request["length"])) == 0 ? 10 : (Convert.ToInt32(Request["length"]));
            var searchvalue = Request["search[value]"] ?? "";
            var sortcoloumnIndex = Convert.ToInt32(Request["order[0][column]"]);
            var SortColumn = "";
            var SortOrder = "";
            var sortDirection = Request["order[0][dir]"] ?? "asc";
            var recordsTotal = 0;
            try
            {
                switch (sortcoloumnIndex)
                {
                    case 0:
                        SortColumn = "Name";
                        break;
                    case 1:
                        SortColumn = "Department";
                        break;
                    case 2:
                        SortColumn = "Branch";
                        break;
                    default:
                        SortColumn = "EmployeeID";
                        break;
                }
                if (sortDirection == "asc")
                    SortOrder = "asc";
                else
                    SortOrder = "desc";
                data = _context.GetEmployeeDetails(start, searchvalue, Length, SortColumn, sortDirection).ToList();
                recordsTotal = data.Count > 0 ? data[0].TotalRecords : 0;
            }
            catch (Exception ex)
            {

            }
            return Json(new { data = data, recordsTotal = recordsTotal, recordsFiltered = recordsTotal }, JsonRequestBehavior.AllowGet);
        }

    }
}