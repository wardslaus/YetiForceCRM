<?php
/*+***********************************************************************************************************************************
 * The contents of this file are subject to the YetiForce Public License Version 1.1 (the "License"); you may not use this file except
 * in compliance with the License.
 * Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and limitations under the License.
 * The Original Code is YetiForce.
 * The Initial Developer of the Original Code is YetiForce. Portions created by YetiForce are Copyright (C) www.yetiforce.com. 
 * All Rights Reserved.
 *************************************************************************************************************************************/
class Settings_Widgets_Index_View extends Settings_Vtiger_Index_View{

	public function process(Vtiger_Request $request) {
		$moduleName = $request->getModule();
		$qualifiedModuleName = $request->getModule(false);
		$source = $request->get('source');
		$sourceModule = $request->get('sourceModule');
		if($sourceModule != '')
			$source = Vtiger_Functions::getModuleId($sourceModule);
		if($source == '')
			$source = 6;
		$moduleModel = Settings_LangManagement_Module_Model::getInstance($qualifiedModuleName);
		$RelatedModule = $moduleModel->getRelatedModule($source);
		$viewer = $this->getViewer($request);
		$viewer->assign('MODULE_MODEL', $moduleModel );
		$viewer->assign('SOURCE', $source );
		$viewer->assign('SOURCEMODULE', Vtiger_Functions::getModuleName($source) );
		$viewer->assign('WIDGETS', $moduleModel->getWidgets($source) );
		$viewer->assign('RELATEDMODULES', $RelatedModule );
		$viewer->assign('FILTERS', json_encode($moduleModel->getFiletrs($RelatedModule) ));
		//$viewer->assign('EXCLUDEDTYPES', $moduleModel->excludedTypes($source) );
		$viewer->assign('QUALIFIED_MODULE', $qualifiedModuleName);
		$viewer->assign('MODULE', $moduleName);
		$viewer->view('Index.tpl', $qualifiedModuleName);
	}
	public function getHeaderCss(Vtiger_Request $request) {
		$headerCssInstances = parent::getHeaderCss($request);
		$moduleName = $request->getModule();
		$cssFileNames = array(
			"~/layouts/vlayout/modules/Settings/$moduleName/resources/$moduleName.css",
		);
		$cssInstances = $this->checkAndConvertCssStyles($cssFileNames);
		$headerCssInstances = array_merge($headerCssInstances, $cssInstances);

		return $headerCssInstances;
	}
	function getHeaderScripts(Vtiger_Request $request) {
		$headerScriptInstances = parent::getHeaderScripts($request);
		$moduleName = $request->getModule();
		$jsFileNames = array(
			"modules.Settings.$moduleName.resources.$moduleName"
		);
		$jsScriptInstances = $this->checkAndConvertJsScripts($jsFileNames);
		$headerScriptInstances = array_merge($headerScriptInstances, $jsScriptInstances);
		return $headerScriptInstances;
	}
}