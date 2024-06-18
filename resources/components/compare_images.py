import sys
from PIL import Image, ImageChops

def compare_images(image1_path, image2_path):
    img1 = Image.open(image1_path)
    img2 = Image.open(image2_path)
    diff = ImageChops.difference(img1, img2)
    if diff.getbbox():
        return False
    return True

if __name__ == "__main__":
    image1_path = sys.argv[1]
    image2_path = sys.argv[2]
    if compare_images(image1_path, image2_path):
        print("Images are identical")
    else:
        print("Images are different")
        sys.exit(1)

