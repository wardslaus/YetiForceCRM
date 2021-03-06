<?php

/**
 * Record allocation.
 *
 * @copyright YetiForce Sp. z o.o
 * @license   YetiForce Public License 3.0 (licenses/LicenseEN.txt or yetiforce.com)
 * @author    Radosław Skrzypczak <r.skrzypczak@yetiforce.com>
 */
class Settings_RecordAllocation_Index_View extends Settings_Vtiger_Index_View
{
	use \App\Controller\ExposeMethod;

	public function __construct()
	{
		parent::__construct();
		$this->exposeMethod('getPanel');
	}

	public function preProcess(\App\Request $request, $display = true)
	{
		parent::preProcess($request, $display);
		$moduleName = $request->getModule();
		$qualifiedModuleName = $request->getModule(false);
		$viewer = $this->getViewer($request);
		$viewer->assign('QUALIFIED_MODULE', $qualifiedModuleName);
		$viewer->assign('MODULE', $moduleName);
		$viewer->view('IndexPreProcess.tpl', $qualifiedModuleName);
	}

	public function process(\App\Request $request)
	{
		$mode = $request->getMode();
		if (!empty($mode)) {
			echo $this->invokeExposedMethod($mode, $request);

			return;
		}
		$moduleName = $request->getModule();
		$qualifiedModuleName = $request->getModule(false);
		$type = $request->get('type');
		if (empty($type)) {
			$type = 'owner';
		}
		$viewer = $this->getViewer($request);
		$viewer->assign('TYPE', $type);
		$viewer->assign('QUALIFIED_MODULE', $qualifiedModuleName);
		$viewer->assign('MODULE', $moduleName);
		$viewer->view('Index.tpl', $qualifiedModuleName);
	}

	public function getPanel(\App\Request $request)
	{
		$moduleName = $request->getModule();
		$qualifiedModuleName = $request->getModule(false);
		$index = (int) $request->get('index');
		$type = $request->get('type');
		if (empty($type)) {
			$type = 'owner';
		}
		$viewer = $this->getViewer($request);
		$viewer->assign('TYPE', $type);
		$viewer->assign('QUALIFIED_MODULE', $qualifiedModuleName);
		$viewer->assign('MODULE_NAME', $request->getByType('sourceModule', 2));
		$viewer->assign('MODULE_ID', \App\Module::getModuleId($request->getByType('sourceModule', 2)));
		$viewer->assign('INDEX', ++$index);
		$viewer->assign('DATA', Settings_RecordAllocation_Module_Model::getRecordAllocationByModule($type, $request->getByType('sourceModule', 2)));
		$viewer->assign('MODULE', $moduleName);
		$viewer->view('AddPanel.tpl', $qualifiedModuleName);
	}

	public function getFooterScripts(\App\Request $request)
	{
		return array_merge(parent::getFooterScripts($request), $this->checkAndConvertJsScripts([
			'~libraries/datatables.net/js/jquery.dataTables.js',
			'~libraries/datatables.net-bs4/js/dataTables.bootstrap4.js',
			'~libraries/datatables.net-responsive/js/dataTables.responsive.js',
			'~libraries/datatables.net-responsive-bs4/js/responsive.bootstrap4.js'
		]));
	}

	public function getHeaderCss(\App\Request $request)
	{
		return array_merge(parent::getHeaderCss($request), $this->checkAndConvertCssStyles([
			'~libraries/datatables.net-bs4/css/dataTables.bootstrap4.css',
			'~libraries/datatables.net-responsive-bs4/css/responsive.bootstrap4.css'
		]));
	}
}
