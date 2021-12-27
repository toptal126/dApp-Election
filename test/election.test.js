const Election = artifacts.require("./Election.sol");

contract("Election", (accounts) => {
  before(async () => {
    this.election = await Election.deployed();
  });

  it("initialize with two candidates", async () => {
    const candidatesCount = await this.election.candidatesCount();
    assert.equal(candidatesCount, 2);
  });

  it("it initializes the candidates with the correct values", async () => {
    const candidate1 = await this.election.candidates(1);
    const candidate2 = await this.election.candidates(2);
    assert.equal(candidate1.id, 1);
    assert.equal(candidate1.name, "Candidate 1");
    assert.equal(candidate1.voteCount, 0);
    assert.equal(candidate2.id, 2);
    assert.equal(candidate2.name, "Candidate 2");
    assert.equal(candidate2.voteCount, 0);
  });

  it("allows voters cast vote", async () => {
    const candidateId = 1;
    await this.election.vote(candidateId, { from: accounts[0] });
    const voted = await this.election.voters(accounts[0]);
    const cadidate = await this.election.candidates(candidateId);
    assert(voted);
    assert.equal(cadidate.voteCount, 1);
  });
});
