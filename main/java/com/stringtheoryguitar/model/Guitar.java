package com.stringtheoryguitar.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList; // Import ArrayList
import java.util.List;      // Import List

public class Guitar implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String brand;
    private String model;
    private String guitarType;
    private Integer yearProduced;
    private String serialNumber;
    private String finishColor;
    private String bodyWood;
    private String neckWood;
    private String fretboardWood;
    private String pickups;
    private String conditionRating;
    private String conditionDetails;
    private BigDecimal price;
    private Timestamp dateAdded;

    private List<GuitarImage> images; // Holds multiple images

    public Guitar() {
        this.images = new ArrayList<>(); // Initialize the list
    }

    // Getters and Setters for standard fields (id, brand, model, etc.)
    // ... (These remain the same as your previous Guitar.java)

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public String getGuitarType() { return guitarType; }
    public void setGuitarType(String guitarType) { this.guitarType = guitarType; }
    public Integer getYearProduced() { return yearProduced; }
    public void setYearProduced(Integer yearProduced) { this.yearProduced = yearProduced; }
    public String getSerialNumber() { return serialNumber; }
    public void setSerialNumber(String serialNumber) { this.serialNumber = serialNumber; }
    public String getFinishColor() { return finishColor; }
    public void setFinishColor(String finishColor) { this.finishColor = finishColor; }
    public String getBodyWood() { return bodyWood; }
    public void setBodyWood(String bodyWood) { this.bodyWood = bodyWood; }
    public String getNeckWood() { return neckWood; }
    public void setNeckWood(String neckWood) { this.neckWood = neckWood; }
    public String getFretboardWood() { return fretboardWood; }
    public void setFretboardWood(String fretboardWood) { this.fretboardWood = fretboardWood; }
    public String getPickups() { return pickups; }
    public void setPickups(String pickups) { this.pickups = pickups; }
    public String getConditionRating() { return conditionRating; }
    public void setConditionRating(String conditionRating) { this.conditionRating = conditionRating; }
    public String getConditionDetails() { return conditionDetails; }
    public void setConditionDetails(String conditionDetails) { this.conditionDetails = conditionDetails; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Timestamp getDateAdded() { return dateAdded; }
    public void setDateAdded(Timestamp dateAdded) { this.dateAdded = dateAdded; }



    public List<GuitarImage> getImages() {
        return images;
    }

    public void setImages(List<GuitarImage> images) {
        this.images = images;
    }


    public String getMainImageUrl() {
        if (this.images != null) {
            for (GuitarImage img : this.images) {
                if (img.isMainImage()) {
                    return img.getImageUrlPath();
                }
            }

            if (!this.images.isEmpty()) {
                return this.images.get(0).getImageUrlPath();
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return "Guitar [id=" + id + ", brand=" + brand + ", model=" + model + ", imagesCount=" + (images != null ? images.size() : 0) + "]";
    }
}