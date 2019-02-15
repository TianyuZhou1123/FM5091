using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OptionPricing
{
    class Program
    {
        static void Main(string[] args)
        {

            // Get essential class's instances.
            Output ResultOutput = new Output();

            //Initial parameters
            double S, K, r, sigma, T, div;
            int N;
            string chose;

            // Create interface
            Console.WriteLine("**************************** " + "Welcome to Option Calculation" + " *****************************");
            Console.WriteLine();
            Console.WriteLine("Please enter underlying price 'S'");

            S = Convert.ToDouble(Console.ReadLine());
            Console.WriteLine("Please enter Strike 'K'");
            K = Convert.ToDouble(Console.ReadLine());
            Console.WriteLine("Please enter Interest Rate 'r'");
            r = Convert.ToDouble(Console.ReadLine());
            Console.WriteLine("Please enter volatility 'sigma'");
            sigma = Convert.ToDouble(Console.ReadLine());
            Console.WriteLine("Please enter Tenor 'T'");
            T = Convert.ToDouble(Console.ReadLine());
            Console.WriteLine("Please enter Tree Steps 'N'");
            N = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Please enter Dividend 'div'");
            div = Convert.ToDouble(Console.ReadLine());
            Console.WriteLine();


            Console.WriteLine("        **********************************************************************");
            Console.WriteLine("        *         Please choose 1-4 to choose property of the option         *");                   
            Console.WriteLine("        *                  1. Calculate European Call Option                 *");
            Console.WriteLine("        *                  2. Calculate European Put Option                  *");
            Console.WriteLine("        *                  3. Calculate American Call Option                 *");
            Console.WriteLine("        *                  4. Calculate American Put Option                  *");
            Console.WriteLine("        **********************************************************************");
            chose = Console.ReadLine();


            switch (chose)
            {
                case "1":
                    // Define properties of class Output
                    ResultOutput.IsEuropean = true;
                    ResultOutput.IsCall = true;
                    // Output the result
                    ResultOutput.Output_Calculation(S, K, r, T, sigma, N, div);
                    Console.WriteLine("The calculation is over, thank you for using it.");
                    break;
                case "2":
                    // Define properties of class Output
                    ResultOutput.IsEuropean = true;
                    ResultOutput.IsCall = false;
                    // Output the result
                    ResultOutput.Output_Calculation(S, K, r, T, sigma, N, div);
                    Console.WriteLine("The calculation is over, thank you for using it.");

                    break;
                case "3":
                    // Define properties of class Output
                    ResultOutput.IsEuropean = false;
                    ResultOutput.IsCall = true;
                    // Output the result
                    ResultOutput.Output_Calculation(S, K, r, T, sigma, N, div);
                    Console.WriteLine("The calculation is over, thank you for using it.");

                    break;

                case "4":
                    // Define properties of class Output
                    ResultOutput.IsEuropean = false;
                    ResultOutput.IsCall = false;
                    // Output the result
                    ResultOutput.Output_Calculation(S, K, r, T, sigma, N, div);
                    Console.WriteLine("The calculation is over, thank you for using it.");

                    break;
                // If something wrong happened.
                default:
                    Console.WriteLine("Attention! You didn't follow the instruction, punish you input from beginning!!");
                    break;
            }


        }
    }
}
