package model;

import java.util.Date;

public class Maintenance {
    private String maintenanceId;
    private String facilityId;
    private Date startDate;
    private Date endDate;
    private String description;
    private String status; // e.g., "In Progress", "Done"

    // NetBeans Tip: Right-click > Insert Code > Getter and Setter to generate these
    public String getMaintenanceId() { return maintenanceId; }
    public void setMaintenanceId(String maintenanceId) { this.maintenanceId = maintenanceId; }

    public String getFacilityId() { return facilityId; }
    public void setFacilityId(String facilityId) { this.facilityId = facilityId; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}