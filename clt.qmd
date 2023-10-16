---
title: Central Limit Theorem
jupyter: envpy39
---

# Week 1 - Blockchain Principles

**Learning Goal**: By the end of the lesson, students should be able to:

1. Understand the basic principles of Blockchain and the technology around it.
2. Recognize the relevance of Blockchain in a crustless environment.
3. Apply Blockchain concepts to solve a simple but practical business problem.

To start with, watch the following video to get a good understanding of what Blockchain is and what it can be used for. [https://youtu.be/Pl8OlkkwRpc?si=17EhwQaay-sWZy0J](https://youtu.be/Pl8OlkkwRpc?si=17EhwQaay-sWZy0J)

```{=html}
<div class="ratio ratio-16x9 m-5 w-75">
<iframe width="560" height="315" src="https://youtu.be/Pl8OlkkwRpc?si=17EhwQaay-sWZy0J</div>
```

**Introduction to the Central Limit Theorem (CLT):**

The Central Limit Theorem is a fundamental concept in statistics. It states that, regardless of the shape of the original distribution of a large dataset, the distribution of the sample means will approach a normal distribution (bell-shaped curve) as the sample size increases.

**Pascal's Triangle:**

Pascal's Triangle is a triangular array of numbers where each number is the sum of the two numbers directly above it. The rows of Pascal's Triangle represent the coefficients in the binomial expansion.

**Example:**

Consider a simple coin toss, where you have two outcomes: heads (H) or tails (T). If you were to toss the coin twice, the possible outcomes are:

1. HH
2. HT
3. TH
4. TT

Now, let's look at the third row of Pascal's Triangle:

```
    1
   1 1
  1 2 1
```

The third row (1, 2, 1) represents the number of ways to get 0, 1, or 2 heads when tossing the coin twice:

1. 0 heads: TT (1 way)
2. 1 head: HT or TH (2 ways)
3. 2 heads: HH (1 way)

As you can see, the coefficients in Pascal's Triangle (1, 2, 1) directly correspond to the number of ways each outcome can occur in our coin toss example.

```{python}
def generate_pascals_triangle(n):
    """Generate Pascal's Triangle up to n rows."""
    triangle = []
    
    for i in range(n):
        if i == 0:
            triangle.append([1])
        else:
            prev_row = triangle[i-1]
            new_row = [1]  # Start with a 1
            
            # Calculate the middle values based on the previous row
            for j in range(len(prev_row) - 1):
                new_row.append(prev_row[j] + prev_row[j+1])
                
            new_row.append(1)  # End with a 1
            triangle.append(new_row)
    
    return triangle

def display_triangle(triangle):
    """Display Pascal's Triangle."""
    n = len(triangle)
    for i in range(n):
        # Print spaces for formatting
        print(" " * (n - i), end="")
        
        # Print the values in the row
        for value in triangle[i]:
            print(value, end=" ")
        print()  # Move to the next line

# Generate and display Pascal's Triangle for 10 rows
triangle = generate_pascals_triangle(10)
display_triangle(triangle)
```

For our purposes, the key takeaway from Pascal's Triangle is that as you move down the rows, the distribution of numbers starts to resemble a bell-shaped curve, especially when you consider the relative probabilities of each outcome in a binomial experiment. This becomes even more evident as you expand to more coin tosses or, in mathematical terms, higher binomial expansions.

**Galton Board:**

The Galton Board, also known as a "bean machine", is a device that demonstrates the central limit theorem in action. It consists of a vertical board with pegs arranged in a triangular pattern. When a ball is dropped from the top, it bounces off the pegs randomly, either moving left or right, until it reaches the bottom.

As more and more balls are dropped, they start to form a distribution at the bottom that looks like a bell-shaped curve. This is a visual representation of the normal distribution.

```{=html}
<div id="renderHere" class="my-5"></div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/matter-js/0.12.0/matter.js"></script>
        <script>
            var Example = Example || {};

            Example.galton = function () {
                var Engine = Matter.Engine,
                    Render = Matter.Render,
                    Runner = Matter.Runner,
                    Composite = Matter.Composite,
                    Composites = Matter.Composites,
                    Common = Matter.Common,
                    MouseConstraint = Matter.MouseConstraint,
                    Mouse = Matter.Mouse,
                    World = Matter.World,
                    Bodies = Matter.Bodies;

                // create engine
                var engine = Engine.create({
                        enableSleeping: true,
                    }),
                    world = engine.world;

                // create renderer
                var render = Render.create({
                    element: document.getElementById("renderHere"),
                    engine: engine,
                    options: {
                        width: 500,
                        height: 830,
                        wireframes: false,
                    },
                });

                Render.run(render);

                // create runner
                var runner = Runner.create();
                Runner.run(runner, engine);

                const size = 4;

                // add bodies
                let total = 1400;
                setInterval(() => {
                    if (total-- > 0) {
                        const circle = Bodies.circle(
                            250 + (-0.5 + Math.random()),
                            -20,
                            size,
                            {
                                friction: 0.00001,
                                restitution: 0.5,
                                density: 0.001,
                                frictionAir: 0.042,
                                sleepThreshold: 25,
                                render: {
                                    fillStyle: "#ff00ff",
                                    visible: true,
                                },
                            }
                        );

                        Matter.Events.on(circle, "sleepStart", () => {
                            Matter.Body.setStatic(circle, true);
                        });
                        World.add(world, circle);
                    }
                }, 10);

                const pegs = [];
                const spacingY = 35;
                const spacingX = 40;
                var i, j, lastI;
                for (i = 0; i < 13; i++) {
                    for (j = 1; j < i; j++) {
                        pegs.push(
                            Bodies.circle(
                                250 + (j * spacingX - i * (spacingX / 2)),
                                i * spacingY,
                                size,
                                {
                                    isStatic: true,
                                    render: {
                                        fillStyle: "#ffffff",
                                        visible: true,
                                    },
                                }
                            )
                        );
                    }
                    lastI = i;
                }
                for (i = 0; i < 15; i++) {
                    World.add(
                        world,
                        Bodies.rectangle(
                            110 - spacingX + (j * spacingX - i * spacingX),
                            lastI * spacingY + 215,
                            size / 2,
                            lastI + 300,
                            {
                                isStatic: true,
                                render: {
                                    fillStyle: "#ffffff",
                                    visible: true,
                                },
                                chamfer: {
                                    radius: [size * 0.4, size * 0.4, 0, 0],
                                },
                            }
                        )
                    );
                }
                World.add(
                    world,
                    Bodies.rectangle(250, lastI * 1.33 * spacingY + 257, 1000, 50, {
                        isStatic: true,
                        render: {
                            fillStyle: "#ffffff",
                            visible: true,
                        },
                    })
                );

                World.add(world, pegs);

                return {
                    engine: engine,
                    runner: runner,
                    render: render,
                    canvas: render.canvas,
                    stop: function () {
                        Matter.Render.stop(render);
                        Matter.Runner.stop(runner);
                    },
                };
            };

            Example.galton();
        </script>
```

**Connecting the Dots:**

* **Pascal's Triangle & Galton Board**: The progression of rows in Pascal's Triangle can be thought of as the journey of a ball in the Galton Board. As you move down the rows in Pascal's Triangle, the distribution of numbers (and their associated probabilities) starts to look like the distribution of balls in the Galton Board. Both show a tendency towards a bell-shaped curve as the number of trials or steps increases.
* **Central Limit Theorem**: Just as the distribution of balls in the Galton Board approaches a normal distribution with more trials, the CLT tells us that the distribution of sample means will also approach a normal distribution as the sample size increases, regardless of the shape of the original distribution.

**Application of the Central Limit Theorem in Finance**:

1. **Portfolio Diversification**:
   * Individual assets, like stocks, might have returns that are volatile and don't follow a normal distribution. However, when many such assets with different risk-return profiles are combined into a portfolio, the CLT comes into play. The average return of the portfolio, derived from a large number of assets, tends to follow a normal distribution, even if individual asset returns do not.
   * This principle is the foundation of diversification, where the aim is to combine assets in such a way that the overall risk of the portfolio is minimized while achieving a desired return.
2. **Value at Risk (VaR) Calculation**:
   * One of the key metrics used by financial institutions to measure and manage risk is Value at Risk (VaR). VaR provides an estimate of the potential loss an investment portfolio could face over a specified period for a given confidence interval.
   * Given that the portfolio returns tend to be normally distributed (thanks to the CLT), financial institutions can use statistical methods to calculate VaR. For instance, if a portfolio has a one-day 95% VaR of $1 million, it means that there's a 5% chance the portfolio will lose more than $1 million over the next day.

**Example**: Imagine a hedge fund that invests in 100 different stocks from various sectors. Some stocks might be highly volatile tech startups, while others might be stable utility companies. Individually, each stock's return might be unpredictable and not normally distributed. However, when combined into a portfolio, the average return of these 100 stocks will approximate a normal distribution due to the CLT.

Now, let's say the hedge fund wants to assess its risk. Using the CLT and the normal distribution of the portfolio returns, the fund can calculate its VaR. If the fund determines that its one-day 95% VaR is $2 million, the fund's managers know there's a 5% chance of losing more than $2 million in a day. This information is crucial for making informed investment decisions, setting aside capital reserves, and communicating risks to stakeholders.
