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
class OrdersRejected{
	public $name = 'Orders rejected';
	public $sequence = 7;
	public $reference = 'SalesOrder';
	
    public function process( $instance ) {
		global $log;
		$log->debug("Entering OrdersRejected::process() method ...");
		$adb = PearDatabase::getInstance();
		$salesorder ='SELECT COUNT(salesorderid) as count FROM vtiger_salesorder
				INNER JOIN vtiger_crmentity ON vtiger_crmentity.crmid=vtiger_salesorder.salesorderid
				AND vtiger_crmentity.deleted=0
				WHERE vtiger_salesorder.potentialid = ? AND vtiger_salesorder.sostatus = ? ';
		$result = $adb->pquery($salesorder, array($instance->getId(), 'Cancelled'));
		$count = $adb->query_result($result, 0, 'count');
		$log->debug("Exiting OrdersRejected::process() method ...");
		return $count;
    }
}