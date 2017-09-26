package paasta.delivery.pipeline.ui.job;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.job
 *
 * @author REX
 * @version 1.0
 * @since 5/23/2017
 */
public class ConfigType {

    private String typeName;
    private String typeValue;

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeValue() {
        return typeValue;
    }

    public void setTypeValue(String typeValue) {
        this.typeValue = typeValue;
    }

    @Override
    public String toString() {
        return "ConfigType{" +
                "typeName='" + typeName + '\'' +
                ", typeValue='" + typeValue + '\'' +
                '}';
    }

}
