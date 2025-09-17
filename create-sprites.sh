#!/bin/bash

# Directory containing people folders
PEOPLE_DIR="static/images/people"
OUTPUT_DIR="static/images/sprites"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through each person's directory
for person_dir in "$PEOPLE_DIR"/*; do
  if [ -d "$person_dir" ]; then
    person_name=$(basename "$person_dir")
    echo "Processing $person_name..."
    
    # Check if this person has the required images (1.jpg through 9.jpg)
    has_images=true
    for i in {1..9}; do
      if [ ! -f "$person_dir/$i.jpg" ]; then
        has_images=false
        break
      fi
    done
    if [ "$has_images" = true ]; then
      # Create a temporary directory for processed images
      tmp_dir=$(mktemp -d)
      
      # Process each image: crop to square and resize
      for i in {1..9}; do
        # Get image dimensions
        dimensions=$(identify -format "%w %h" "$person_dir/$i.jpg")
        width=$(echo $dimensions | cut -d' ' -f1)
        height=$(echo $dimensions | cut -d' ' -f2)
        
        # Calculate crop dimensions (square from center)
        if [ $width -gt $height ]; then
          crop_size=$height
          x_offset=$(( (width - height) / 2 ))
          y_offset=0
        else
          crop_size=$width
          x_offset=0
          y_offset=$(( (height - width) / 2 ))
        fi
        
        # Crop and resize to 300x300
        convert "$person_dir/$i.jpg" -crop ${crop_size}x${crop_size}+${x_offset}+${y_offset} -resize 300x300 "$tmp_dir/$i.jpg"
      done
      
      # Create sprite sheet (3x3 grid)
      # Arrange images in this order:
      # 1=top-left, 2=top, 3=top-right
      # 4=left,     5=center, 6=right
      # 7=bottom-left, 8=bottom, 9=bottom-right
      montage "$tmp_dir/1.jpg" "$tmp_dir/2.jpg" "$tmp_dir/3.jpg" \
              "$tmp_dir/4.jpg" "$tmp_dir/5.jpg" "$tmp_dir/6.jpg" \
              "$tmp_dir/7.jpg" "$tmp_dir/8.jpg" "$tmp_dir/9.jpg" \
              -tile 3x3 -geometry 300x300+0+0 "$OUTPUT_DIR/$person_name-sprite.jpg"
      
      # Clean up
      rm -rf "$tmp_dir"
      echo "Created sprite for $person_name"
    else
      echo "Skipping $person_name (missing required images)"
    fi
  fi
done


tapnesh public/images/sprites/ 2>/dev/null
echo "Sprite generation complete!" 