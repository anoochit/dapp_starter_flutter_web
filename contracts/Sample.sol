// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Sample {
    // contract name
    string public name = "Sample";

    // image count
    uint256 public imageCount = 0;

    // store image as map in state variable
    mapping(uint256 => Image) public images;

    // struct of image
    struct Image {
        uint256 id;
        string hash;
        string description;
        uint256 tipAmount;
        address author;
    }

    event imageTipped(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address author
    );

    event createImage(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address author
    );

    // upload image :
    // author upload image to ipfs, it return hash of image.
    // we store hash of image in the blockchain
    function uploadImage(string memory _imageHash, string memory _description)
        public
    {
        require(msg.sender != address(0x0));
        require(bytes(_imageHash).length > 0);
        require(bytes(_description).length > 0);

        // increment image id
        imageCount++;

        // add image to contract
        images[imageCount] = Image(
            imageCount,
            _imageHash,
            _description,
            0,
            msg.sender
        );

        emit createImage(imageCount, _imageHash, _description, 0, msg.sender);
    }

    // tip image :
    // tipper send tip via image listed
    function tipImageOwner(uint256 _id) public payable {
        require(_id > 0 && _id <= imageCount);

        Image memory _image = images[_id];
        address _author = _image.author;
        payable(_author).transfer(msg.value);
        _image.tipAmount = _image.tipAmount + msg.value;
        images[_id] = _image;

        emit createImage(
            _id,
            _image.hash,
            _image.description,
            _image.tipAmount,
            msg.sender
        );
    }
}
