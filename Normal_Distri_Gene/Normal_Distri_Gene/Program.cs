using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;

namespace Normal_Distri_Gene
{
    class Program
    {
        Random rnd = new Random();

        static void Main(string[] args)
        {
            //// Add twelve uniform values to generate normally distributed variables.
            Console.WriteLine("It is generating nomal r.v. using the simple way");
            Console.WriteLine("How many normally distributed random variable do you want to generate?");
            // Set the number of random variables.
            int n = Convert.ToInt32(Console.ReadLine());
            Gene_Norm_Simp(n);
            Console.ReadLine();
            

            //// Using Box-Muller to generate normally distributed variables.
            Console.WriteLine("Next is generating nomal r.v. using Box_Muller way");
            Console.ReadLine();

            // Use the Box_Muller method.
            double rv1;
            rv1 = Box_Muller(out double rv2);
            Console.WriteLine("The first normally r.v. is " + rv1);
            Console.WriteLine("The second normally r.v. is " + rv2);
            Console.ReadLine();

            // Generate two jointly normal random variables using the r.v above.
            string jug;
            Console.WriteLine("Do you want to generate two jointly normal random variables using the r.v above? (Please enter 'Y' or 'N')");
            jug = Console.ReadLine();
            // Judge whether user wants to generate jointly normal random variables or not.
            // If user wants to do that, generate the r.v. using method.
            if (jug == "Y")
            {
                double rho;
                double jnm2;
                Console.WriteLine("Please enter a number as correlation value between the two r.v.(It should beween -1 to 1)");
                rho = Convert.ToDouble(Console.ReadLine());
                // If rho between -1 and 1, then run the jointly_norm method.
                if (rho <= 1 && rho >= -1)
                {
                    jnm2 = jointly_norm(rv1, rv2, rho, out double jnm1);
                    Console.WriteLine("The first jointly normal r.v. is " + jnm1);
                    Console.WriteLine("The second jointly normal r.v. is " + jnm2);
                    Console.ReadLine();
                }
                // If rho is not between -1 and 1, then the user lose the chance to generate jointly normal random variables.
                else
                {
                    Console.WriteLine("Oh, you didn't follow the instruction, so you lost the chance to generate two jointly normal random variables.");
                    Console.ReadLine();
                }
            }
            // If the user doesn't want to do that, just go to next part.
            else if(jug == "N")
            {
                Console.WriteLine("Ok! Let's go to the next part!");
                Console.ReadLine();
            }
            // If the user doesn't follow the instruction, then he lose the chance.
            else
            {
                Console.WriteLine("Oh, you didn't follow the instruction, so you lost the chance to generate two jointly normal random variables.");
                Console.ReadLine();
            }




            //// Using Polar rejection to generate normally distributed variables.
            Console.WriteLine("Next is generating nomal r.v. using Polar rejection");
            Console.ReadLine();

            // Use the Polar rejection method.
            double z1;
            z1 = Norm_Polar(out double z2);
            Console.WriteLine("The first normally r.v. is " + z1);
            Console.WriteLine("The second normally r.v. is " + z2);
            Console.ReadLine();

            // Generate two jointly normal random variables using the r.v above.
            string jus;
            Console.WriteLine("Do you want to generate two jointly normal random variables using the r.v above? (Please enter 'Y' or 'N')");
            jus = Console.ReadLine();
            // Judge whether user wants to generate jointly normal random variables or not.
            // If user wants to do that, generate the r.v. using method.
            if (jus == "Y")
            {
                double rho;
                double jnm2;
                Console.WriteLine("Please enter a number as correlation value between the two r.v.(It should beween -1 to 1)");
                rho = Convert.ToDouble(Console.ReadLine());
                // If rho between -1 and 1, then run the jointly_norm method.
                if (rho <= 1 && rho >= -1)
                {
                    jnm2 = jointly_norm(z1, z2, rho, out double jnm1);
                    Console.WriteLine("The first jointly normal r.v. is " + jnm1);
                    Console.WriteLine("The second jointly normal r.v. is " + jnm2);
                }
                // If rho is not between -1 and 1, then the user lose the chance to generate jointly normal random variables.
                else
                {
                    Console.WriteLine("Oh, you didn't follow the instruction, so you lost the chance to generate two jointly normal random variables.");
                    Console.WriteLine("Thank you! The program is done!");
                    Console.ReadLine();
                }
            }
            // If the user doesn't want to do that, just say goodbye to him.
            else if (jus == "N")
            {
                Console.WriteLine("Ok! See you next life~");
                Console.ReadLine();
            }
            // If the user doesn't follow the instruction, then he lose the chance.
            else
            {
                Console.WriteLine("Oh, you didn't follow the instruction, so you lost the chance to generate two jointly normal random variables.");
               
            }
            // All the program is end here.
            Console.WriteLine("Thank you! The program is done!");
            Console.ReadLine();


        }



        /// <summary>
        /// A method that use adding twelve uniform values to generate normally distributed random variables.
        /// </summary>
        /// <param name="n"></param> The number of generated norammly distributed random variables.
        static void Gene_Norm_Simp(int n)
        {
            double randn, norm_randn;
            double sum_randn = 0;
            Program pg = new Program();
            // Do the loop to generate number of r.v. that user wants
            for (int j = n; j > 0; j--)
            {
                // When i<=12, do the loop to generate 12 different uniform values.
                for (int i = 1; i <= 12; i++)
                {
                    // Reference the rnd
                    randn = pg.rnd.NextDouble();
                    sum_randn = sum_randn + randn;

                }
                norm_randn = sum_randn - 6;
                sum_randn = 0;
                // Output
                Console.WriteLine("The r.v. using simple way is " + norm_randn);
            }
            

            
        }




        /// <summary>
        /// A method that use Box-Muller method to generate normally distributed random variables.
        /// </summary>
        /// <param name="z2"></param> The 2nd normally distributed random variable that will return.
        /// <returns>The 1st normally distributed random variable that will return.</returns>
        static double Box_Muller(out double z2)
        {
            Program pg = new Program();
            double randn1, randn2, z1;
            // Generate two different uniform variables.
            randn1 = pg.rnd.NextDouble();
            randn2 = pg.rnd.NextDouble();
            // Box-Muller formula
            z1 = Math.Sqrt(-2 * Math.Log(randn1)) * Math.Cos(2 * Math.PI * randn2);
            z2 = Math.Sqrt(-2 * Math.Log(randn1)) * Math.Sin(2 * Math.PI * randn2);
            return z1;
        }





        /// <summary>
        /// A method that use Polar rejection method to generate normally distributed random variables.
        /// </summary>
        /// <param name="z2"></param> The 2nd normally distributed random variable that will return.
        /// <returns>The 1st normally distributed random variable that will return.</returns>
        static double Norm_Polar(out double z2)
        {
            Program pg = new Program();
            double randn1, randn2;
            double c, w, z1;

            // If w > 1, repeat generating 2 uniform variables, if not, continue
            do
            {
                randn1 = 2 * pg.rnd.NextDouble() - 1;
                randn2 = 2 * pg.rnd.NextDouble() - 1;

                w = randn1 * randn1 + randn2 * randn2;

            } while (w > 1);

            c = Math.Sqrt(-2 * Math.Log(w) / w);

            z1 = c * randn1;
            z2 = c * randn2;

            return z1;
                  
        }


        /// <summary>
        /// A method that use 2 normally distributed random variables to generate 2 jointly normal random variables.
        /// </summary>
        /// <param name="rv1"></param> The 1st normally distributed random variable you want to use in this method.
        /// <param name="rv2"></param> The 2nd normally distributed random variable you want to use in this method.
        /// <param name="rho"></param> The correlation between 2 jointly normal random variables.
        /// <param name="jnm1"></param> The 1st jointly normal random variable that will return.
        /// <returns>The 2nd jointly normal random variable that will return.</returns>
        static double jointly_norm(double rv1, double rv2, double rho, out double jnm1)
        {
            double jnm2;

            jnm1 = rv1;
            jnm2 = rho * rv1 + Math.Sqrt(1 - rho * rho) * rv2;

            return jnm2;
        }
    }
}




