package com.sys.manageColumn.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sys.manageColumn.model.ManageColumn;
import com.sys.manageColumn.service.ManageColumnService;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.controller.BaseController;

/**
 * @author keeny
 * @time 2015年02月04日 18:53:45
 */
@Controller
@RequestMapping("/manageColumn")
public class ManageColumnController extends BaseController {

	// private static Logger logger =
	// Logger.getLogger(ManageColumnController.class); //Logger

	@Autowired
	private ManageColumnService managecolumnService = null;

	/***************** 页面中转 *********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) {

		ManageColumn managecolumn = new ManageColumn();

		managecolumn.setParentColumnID(-1);
		managecolumn.setState(1);

		List<ManageColumn> managecolumnList = managecolumnService.getManageColumnBaseList(managecolumn);
		model.addAttribute("parentColumnList", managecolumnList);

		return "/sys/manageColumn/manageColumnIndex";
	}

	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model) {
		ManageColumn managecolumn = new ManageColumn();

		managecolumn.setParentColumnID(-1);
		managecolumn.setState(1);

		List<ManageColumn> managecolumnList = managecolumnService.getManageColumnBaseList(managecolumn);
		model.addAttribute("parentColumnList", managecolumnList);

		return "/sys/manageColumn/manageColumnAdd";
	}

	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate(HttpServletRequest request, HttpServletResponse response, Model model) {
		Integer columnId = RequestHandler.getInteger(request, "columnId");
		ManageColumn managecolumn1 = new ManageColumn();
		managecolumn1.setColumnId(columnId);
		ManageColumn managecolumn = managecolumnService.getManageColumn(managecolumn1);
		model.addAttribute("managecolumn", managecolumn);

		managecolumn = new ManageColumn();

		managecolumn.setParentColumnID(-1);
		managecolumn.setState(1);

		List<ManageColumn> managecolumnList = managecolumnService.getManageColumnBaseList(managecolumn);
		model.addAttribute("parentColumnList", managecolumnList);

		return "/sys/manageColumn/manageColumnUpdate";
	}

	/************* Public Methods *************/

	@RequestMapping(value = "/getManageColumnList", method = RequestMethod.GET)
	public String getManageColumnList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageColumn managecolumn = new ManageColumn();

			Integer columnId = RequestHandler.getInteger(request, "columnId");
			managecolumn.setColumnId(columnId);

			String columnName = RequestHandler.getString(request, "columnName");
			managecolumn.setColumnName(columnName);

			String columnUrl = RequestHandler.getString(request, "columnUrl");
			managecolumn.setColumnUrl(columnUrl);

			Integer parentColumnID = RequestHandler.getInteger(request, "parentColumnID");
			managecolumn.setParentColumnID(parentColumnID);

			Integer state = RequestHandler.getInteger(request, "state");
			managecolumn.setState(state);

			Integer columnOrder = RequestHandler.getInteger(request, "columnOrder");
			managecolumn.setColumnOrder(columnOrder);

			String columnImg = RequestHandler.getString(request, "columnImg");
			managecolumn.setColumnImg(columnImg);

			// 分页开始
			Integer pageNo = RequestHandler.getPageNo(request, "pageNo");
			Integer rowCount = RequestHandler.getPageSize(request, "rowCount");

			int from = RequestHandler.getFromByPage(pageNo, rowCount);
			managecolumn.setRowStart(from);
			managecolumn.setRowCount(rowCount);
			// 分页结束
			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			managecolumn.setSortColumn(sortColumn);

			int managecolumnListCount = managecolumnService.getManageColumnListCount(managecolumn);
			ResponseList<ManageColumn> managecolumnList = null;
			if (managecolumnListCount > 0) {
				managecolumnList = managecolumnService.getManageColumnList(managecolumn);
			} else {
				managecolumnList = new ResponseList<ManageColumn>();
			}
			// 设置数据总数
			managecolumnList.setTotalResults(managecolumnListCount);

			writeSuccessMsg("ok", managecolumnList, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	/**
	 * @time : 2015年2月13日 上午11:16:40
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 菜单移动
	 */
	@RequestMapping(value = "/moveColumn", method = RequestMethod.POST)
	public String moveColumn(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageColumn managecolumn = new ManageColumn();

			Integer columnId = RequestHandler.getInteger(request, "columnId");
			Integer parentColumnID = RequestHandler.getInteger(request, "parentColumnID");
			managecolumn.setParentColumnID(parentColumnID);
			
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			managecolumn.setSortColumn(sortColumn);
			List<ManageColumn> list = managecolumnService.getManageColumnBaseList(managecolumn);

			String sign = RequestHandler.getString(request, "sign");

			ManageColumn column = null;// 交换对象
			ManageColumn currentColumn = null;// 当前对象

			int currentIndex = 0;// 当前对象索引
			for (int i = 0; i < list.size(); i++) {
				ManageColumn column1 = list.get(i);
				if (column1.getColumnId().equals(columnId)) {
					currentIndex = i;
					break;
				}
			}
			if (sign.equals("up")) {// 上移动
				if (currentIndex == 0) {// 已经是第一个了不能向上移动
					writeSuccessMsg("已经是第一个了",null, response);
				} else {
					column = list.get(currentIndex - 1);// 获取上一个对象
					currentColumn = list.get(currentIndex);// 当前对象
				}
			} else if (sign.equals("down")) {// 下移动
				if (currentIndex == (list.size() - 1)) {// 已经是最后一个了不能向下移动
					writeSuccessMsg("已经是最后一个了",null, response);
				} else {
					column = list.get(currentIndex + 1);// 获取下一个对象
					currentColumn = list.get(currentIndex);// 当前对象
				}
			}

			ManageColumn column2 = new ManageColumn();
			column2.setColumnId(column.getColumnId());
			column2.setColumnOrder(currentColumn.getColumnOrder());
			managecolumnService.updateManageColumn(column2);// 更新序号

			column2 = new ManageColumn();
			column2.setColumnId(currentColumn.getColumnId());
			column2.setColumnOrder(column.getColumnOrder());
			managecolumnService.updateManageColumn(column2);// 更新序号

			writeSuccessMsg("ok", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/getManageColumnBaseList", method = RequestMethod.GET)
	public String getManageColumnBaseList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageColumn managecolumn = new ManageColumn();

			Integer columnId = RequestHandler.getInteger(request, "columnId");
			managecolumn.setColumnId(columnId);

			String columnName = RequestHandler.getString(request, "columnName");
			managecolumn.setColumnName(columnName);

			String columnUrl = RequestHandler.getString(request, "columnUrl");
			managecolumn.setColumnUrl(columnUrl);

			Integer parentColumnID = RequestHandler.getInteger(request, "parentColumnID");
			managecolumn.setParentColumnID(parentColumnID);

			Integer state = RequestHandler.getInteger(request, "state");
			managecolumn.setState(state);

			Integer columnOrder = RequestHandler.getInteger(request, "columnOrder");
			managecolumn.setColumnOrder(columnOrder);

			String columnImg = RequestHandler.getString(request, "columnImg");
			managecolumn.setColumnImg(columnImg);

			List<ManageColumn> managecolumnList = managecolumnService.getManageColumnBaseList(managecolumn);

			writeSuccessMsg("ok", managecolumnList, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/addManageColumn", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {

			ManageColumn managecolumn = new ManageColumn();
			String columnName = RequestHandler.getString(request, "columnName");
			managecolumn.setColumnName(columnName);
			String columnUrl = RequestHandler.getString(request, "columnUrl");
			managecolumn.setColumnUrl(columnUrl);
			Integer parentColumnID = RequestHandler.getInteger(request, "parentColumnID");
			managecolumn.setParentColumnID(parentColumnID);
			Integer state = RequestHandler.getInteger(request, "state");
			managecolumn.setState(state);
			Integer columnOrder = RequestHandler.getInteger(request, "columnOrder");
			managecolumn.setColumnOrder(columnOrder);
			String columnImg = RequestHandler.getString(request, "columnImg");
			managecolumn.setColumnImg(columnImg);

			Integer columnId = managecolumnService.insertManageColumn(managecolumn);
			managecolumn = new ManageColumn();
			managecolumn.setColumnId(columnId);
			managecolumn.setColumnOrder(columnId);
			managecolumnService.updateManageColumn(managecolumn);// 更新排序

			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/updateManageColumn", method = RequestMethod.POST)
	public String updateManageColumn(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageColumn managecolumn = new ManageColumn();

			Integer columnId = RequestHandler.getInteger(request, "columnId");
			managecolumn.setColumnId(columnId);

			String columnName = RequestHandler.getString(request, "columnName");
			managecolumn.setColumnName(columnName);

			String columnUrl = RequestHandler.getString(request, "columnUrl");
			managecolumn.setColumnUrl(columnUrl);

			Integer parentColumnID = RequestHandler.getInteger(request, "parentColumnID");
			managecolumn.setParentColumnID(parentColumnID);

			Integer state = RequestHandler.getInteger(request, "state");
			managecolumn.setState(state);

			Integer columnOrder = RequestHandler.getInteger(request, "columnOrder");
			managecolumn.setColumnOrder(columnOrder);

			String columnImg = RequestHandler.getString(request, "columnImg");
			managecolumn.setColumnImg(columnImg);

			managecolumnService.updateManageColumn(managecolumn);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeManageColumn", method = RequestMethod.POST)
	public String removeManageColumn(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageColumn managecolumn = new ManageColumn();
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			managecolumn.setColumnId(columnId);

			ManageColumn managecolumn1 = new ManageColumn();
			managecolumn1.setParentColumnID(columnId);
			int c = managecolumnService.getManageColumnListCount(managecolumn1);//有子节点的菜单不让删除
			if(c == 0){
				managecolumnService.removeManageColumn(managecolumn);
				writeSuccessMsg("删除成功", null, response);
			}else{
				writeErrorMsg("此菜单有子菜单不能删除", null, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeAllManageColumn", method = RequestMethod.POST)
	public String removeAllManageColumn(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			String columnIds = RequestHandler.getString(request, "columnIds");
			if (columnIds != null) {
				boolean removeall = true;
				String[] columnIdStr = columnIds.split(",");
				if (columnIdStr != null && columnIdStr.length != 0) {
					for (String columnId : columnIdStr) {
						ManageColumn manageColumn = new ManageColumn();
						manageColumn.setColumnId(Integer.valueOf(columnId));
						
						ManageColumn managecolumn1 = new ManageColumn();
						managecolumn1.setParentColumnID(Integer.valueOf(columnId));
						int c = managecolumnService.getManageColumnListCount(managecolumn1);//有子节点的菜单不让删除
						if(c == 0){
							managecolumnService.removeManageColumn(manageColumn);
						}else{
							removeall = false;
						}
					}
				}
				if(removeall){
					writeSuccessMsg("删除成功", null, response);
				}else{
					writeErrorMsg("部分菜单未删除，因其有子菜单", null, response);
				}
			}else{
				writeErrorMsg("请选择菜单", null, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
}
