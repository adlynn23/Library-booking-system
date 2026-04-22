/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class Maintenance {

    private int maintenanceId;
    private int facilityId;
    private String startDate;
    private String endDate;
    private String status;

    // getters & setters
    public int getMaintenanceId() {
        return maintenanceId;
    }

    public int getFacilityId() {
        return facilityId;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public String getStatus() {
        return status;
    }

    public int setMaintenanceId(int aInt) {
        return maintenanceId;
    }

    public int setFacilityId(int aInt) {
        return facilityId;
    }

    public String setStartDate(String string) {
        return startDate;
    }

    public String setEndDate(String string) {
        return endDate;
    }

    public String setStatus(String string) {
        return status;
    }

}
