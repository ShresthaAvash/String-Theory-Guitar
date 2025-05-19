package com.stringtheoryguitar.model;

import java.io.Serializable;
import java.sql.Timestamp; // Good to have if you add date_added to the model

public class GuitarImage implements Serializable {
    private static final long serialVersionUID = 1L;

    private int imageId;
    private int guitarId;
    private String imageUrlPath;
    private boolean isMainImage;
    private Timestamp dateAdded;

    public GuitarImage() {
    }

    public GuitarImage(int guitarId, String imageUrlPath, boolean isMainImage) {
        this.guitarId = guitarId;
        this.imageUrlPath = imageUrlPath;
        this.isMainImage = isMainImage;
    }

    public int getImageId() { return imageId; }
    public void setImageId(int imageId) { this.imageId = imageId; }
    public int getGuitarId() { return guitarId; }
    public void setGuitarId(int guitarId) { this.guitarId = guitarId; }
    public String getImageUrlPath() { return imageUrlPath; }
    public void setImageUrlPath(String imageUrlPath) { this.imageUrlPath = imageUrlPath; }
    public boolean isMainImage() { return isMainImage; } 
    public void setMainImage(boolean mainImage) { isMainImage = mainImage; }
    public Timestamp getDateAdded() { return dateAdded; }
    public void setDateAdded(Timestamp dateAdded) { this.dateAdded = dateAdded; }


    @Override
    public String toString() {
        return "GuitarImage{" +
               "imageId=" + imageId +
               ", guitarId=" + guitarId +
               ", imageUrlPath='" + imageUrlPath + '\'' +
               ", isMainImage=" + isMainImage +
               '}';
    }
}