using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerMovement : MonoBehaviour
{
    [SerializeField] float runSpeed = 10f;
    Vector2 moveInput;
    CapsuleCollider2D myBodyCollider;
    Rigidbody2D myRigidbody;
    Animator myAnimator;
    
    public Inventory inventory;
    void Awake(){
        inventory = new Inventory(21);
    }
    public void DropItem(CollecTable item){
        Vector2 spawnLocation = transform.position;
        Vector2 spawnOffSet = Random.insideUnitCircle * 1.25f;
        CollecTable dropItem =  Instantiate(item, spawnLocation + spawnOffSet, Quaternion.identity);
        dropItem.rigidbody2D.AddForce(spawnOffSet * 2f, ForceMode2D.Impulse);
    }
    void Start()
    {
        myRigidbody = GetComponent<Rigidbody2D>();
        myBodyCollider = GetComponent<CapsuleCollider2D>();
        myAnimator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        Run();
        InteractiveGround();
        FlipSprite();
    }

    private void InteractiveGround()
    {
        if(Input.GetKeyDown(KeyCode.Space)){
            Vector3Int posistion = new Vector3Int((int)transform.position.x, (int)transform.position.y,0);
            if(GameManager.instance.tileManager.IsInteractable(posistion)){
                GameManager.instance.tileManager.SetInteracted(posistion);
            }
        }
    }

    private void Run()
    {
        Vector2 playerVelocity = new Vector2(moveInput.x * runSpeed, moveInput.y * runSpeed);
        myRigidbody.velocity = playerVelocity;

        bool isTurnWalking = Mathf.Abs(myRigidbody.velocity.x) > Mathf.Epsilon;
        bool isUpWalking = playerVelocity.y > 0;
        bool isDownWalking = playerVelocity.y < 0;

        myAnimator.SetBool("IsDownWalking", isDownWalking);
        myAnimator.SetBool("IsUpWalking", isUpWalking);
        myAnimator.SetBool("IsTurnWalking", isTurnWalking);
    }

    void OnMove(InputValue value) {
        moveInput = value.Get<Vector2>();
    }
    private void FlipSprite()
    {
        bool playerTurnRight= myRigidbody.velocity.x > 0;
        bool playerTurnLeft= myRigidbody.velocity.x < 0;

        if (playerTurnRight)
        {
            transform.localScale = new Vector2(Mathf.Sign(-myRigidbody.velocity.x), 1f);
        }
        if (playerTurnLeft)
        {
            transform.localScale = new Vector2(Mathf.Sign(-myRigidbody.velocity.x), 1f);
        }
    }
}
