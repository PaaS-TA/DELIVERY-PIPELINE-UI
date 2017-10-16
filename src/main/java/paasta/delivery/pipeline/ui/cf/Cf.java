package paasta.delivery.pipeline.ui.cf;

import java.util.List;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cf
 *
 * @author REX
 * @version 1.0
 * @since 8/21/2017
 */
public class Cf {

    private String orgName;
    private List spaceList;

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public List getSpaceList() {
        return spaceList;
    }

    public void setSpaceList(List spaceList) {
        this.spaceList = spaceList;
    }

}
