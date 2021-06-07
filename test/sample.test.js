// load contract
const Sample = artifacts.require('Sample')

// use contract
contract('Sample', async ([deployer, author, tipper]) => {

    // check deployed contract
    it('should deployed', async () => {
        const instance = await Sample.deployed();
        const address = await instance.address;
        assert.notEqual(address, '0x0', 'should not address 0');
    });

    // check image can create
    it('create image', async() => {
        const instance = await Sample.deployed();
        await instance.uploadImage('1234', 'descriptiop', { from: author });
        const imageCount = await instance.imageCount();
        assert.equal(imageCount,1, 'image count is correct');
    });

    // check user can send tip
    it('user send a tips', async() => {
        const instance = await Sample.deployed();
        let result = await instance.tipImageOwner(1, {from: tipper, value: web3.utils.toWei('1','Ether')});
        const imageCount = await instance.imageCount();
        const event = result.logs[0].args;
        assert.equal(event.id.toNumber(), imageCount.toNumber(), 'id is correct');
    });
  
});
